#!/bin/sh
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
   sudo apt-get install build-essential ruby1.8-dev
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
   brew install ruby1.8-dev
fi
# Install Mr.Igor for auto-importing python modules
pip install mr.igor
# Link the vimrc to the home folder
ln -s ~/.vim/.vimrc ~/.vimrc
# Run Vim and get bundles installed, then:
cd ~; vim;
