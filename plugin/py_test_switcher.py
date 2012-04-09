"""
" HACK to make this file source'able by vim as well as importable by Python:
python reload(py_test_switcher)
finish
"""

import vim
import os
import re

DEBUG = False

patterns = [
    ('%/__init__.py', '%/tests/test_%.py'),
    ('%.py',          'tests/test_%.py'),
    ('%.py',          'test/test_%.py'),
    ('%.py',          'test_%.py'),
    ('%.py',          '%.txt'),
    ('%.py',          'tests/tests.py'),
    ('%.py',          'tests.py'),
    ('__init__.py',   'tests.py'),
    # Pylons
    ('controllers/%.py',  'tests/functional/test_%.py'),
    ('controllers/%.py',  'tests/test_%.py'),
    ('lib/%.py',          'tests/test_%.py'),
    ('model/__init__.py', 'tests/test_models.py'),
    # well, ...
    ('public/js/ControlPanel/%.js',    'tests/js/test_%.js'),
    # ivija
    ('resources/%.js',    'tests/test_%.js'),
    # new-mg-website
    ('%-en.html.mako', '%-lt.html.mako'),
]

def pattern2regex(pattern):
    if '%' in pattern:
        idx = pattern.index('%') + 1
        pattern = (pattern[:idx].replace('%', '([^/]+)') +
                   pattern[idx:].replace('%', '\\1'))
    return re.compile('(^|/)' + pattern.replace('.', '\\.') + '$')


def try_match(filename, pattern, replacement):
    if DEBUG:
        print 'trying %s -> %s' % (pattern, replacement)
    if '%' in replacement and '%' not in pattern:
        return None
    rx = pattern2regex(pattern)
    if not rx.search(filename):
        return None
    if DEBUG:
        print 'MATCH: %s -> %s' % (pattern, replacement)
    replacement = r'\1' + replacement.replace('%', r'\2')
    candidate = rx.sub(replacement, filename)
    if candidate == filename:
        print 'rejecting %s: same as original'
        return None
    return candidate


def find_all_matches(filename):
    results = []
    for a, b in patterns:
        results.append(try_match(filename, a, b))
        results.append(try_match(filename, b, a))
    return filter(None, results)


def find_best_match(filename, nth=1):
    matches = find_all_matches(filename)
    last_valid_match = None
    for match in matches:
        if os.path.exists(match):
            nth -= 1
            if nth == 0:
                return match
            else:
                last_valid_match = match
    for match in matches:
        if os.path.exists(os.path.dirname(match)):
            nth -= 1
            if nth == 0:
                return match
            else:
                last_valid_match = match
    # there were fewer than n matches, return the last one
    return last_valid_match


def switch_code_and_test(verbose=False):
    global DEBUG
    DEBUG = verbose
    filename = vim.eval('expand("%:p")')
    if DEBUG:
        print filename
    nth = int(vim.eval('v:count1'))
    newfilename = find_best_match(filename, nth)
    if newfilename:
        if DEBUG:
            print '->', newfilename
        vim.command('call SwitchToFile(%r)' % newfilename)
    else:
        pass

