" Vim syntax file
" Language:   iMacros
" Maintainer:   Chib (gruntrush at hotmail dot com)
" Last Change:   2011 Jan 25
"
" Known Bugs:
"  - Strings and URLs in PROMPT or similar commands are highlighted
"  incorrectly
"  - Comands and other keywords are also highlighted incorrectly in the same
"  situation as above
"  - EXTRACT is only highlighted as part of the equal class, although it
"  should also be highlighted as part of the inputtypes class in certain
"  situations too

if exists("b:current_syntax")
   finish
endif

if version < 600
   syntax clear
elseif exists("b:current_syntax")
   finish
endif


setlocal iskeyword+=!
setlocal iskeyword+=:


syntax keyword command ADD BACK CLEAR CLICK CMDLINE DS FILEDELETE FILTER FRAME IMAGECLICK IMAGESEARCH ONCERTIFICATEDIALOG ONDIALOG ONDOWNLOAD ONERRORDIALOG ONLOGIN ONPRINT ONSECURITYDIALOG ONWEBPAGEDIALOG PAUSE PRINT PROMPT PROXY REFRESH SAVEAS SAVEITEM SEARCH SET SIZE STOPWATCH TAB TAG TRAY URL VERSION WAIT SECONDS

syntax keyword equal POS TYPE ATTR FORM BUILD EXTRACT GOTO OPEN T CONTENT RECORDER FOLDER FILE CLOSEALLOTHERS XPATH STATUS BUTTON CLOSE

syntax keyword inbuilt !CLIPBOARD !DATASOURCE !DATASOURCE_COLUMNS !DATASOURCE_LINE !ENCRYPTION !ENDOFPAGE !ERRORIGNORE !ERRORMACRO !EXTRACT !EXTRACT_TEST_POPUP !EXTRACTADD !EXTRACTDIALOG !FILELOG !FILESTOPWATCH !FOLDER_DATASOURCE !FOLDER_STOPWATCH !FOLDERIMACROS !IMAGEX !IMAGEY !LOADCHECK !LOOP !MARKOBJECT !NOW !POPUP_ALLOWED !REPLAYSPEED !REGION_BOTTOM !REGION_LEFT !REGION_RIGHT !REGION_TOP !SINGLESTEP !STOPWATCHTIME !STOPWATCH_HEADER !TAGSOURCEINDEX !TAGX !TAGY !TIMEOUT !TIMEOUT_MACRO !TIMEOUT_PAGE !TIMEOUT_TAG !TIMEOUT_STEP !URLCURRENT !URLSTART !USERAGENT !VAR1 !VAR2 !VAR3
syntax match inbuilt /!COL\d*/

syntax match letters /<SP>\|<BR>\|<LF>\|/

syntax match surrounders /{{.\{-}}}/

syntax keyword specialwords NULL NO YES MEDIUM SLOW FAST

syntax keyword inputtypes A TD SELECT TEXTAREA IMG HTM CPL INPUT TABLE SPAN ALT HREF DIV TITLE FX CR IMAGES ON OFF OK PNG FONT PRE
syntax match inputtypes /INPUT:TEXT\|INPUT:CHECKBOX\|INPUT:SUBMIT\|INPUT:IMAGE\|INPUT:RADIO\|INPUT:HIDDEN\|BODY\|ACTION\|NAME\|ID\|VALUE\|SRC\|TXT\|CLASS\|INPUT:PASSWORD\|INPUT:FILE\|HREF\|INPUT:BUTTON/

syntax match equalsign /=\|&&/

syntax match acomment /^\s*\zs'.*/

syntax match url /http.\{-}\_[    ]/

syntax match quote /".\{-}"/


highlight link command Function
highlight link equal Statement
highlight link inbuilt Number
highlight link letters Special
highlight link surrounders Tag
highlight link specialwords Label
highlight link inputtypes Type
highlight link equalsign Operator
highlight link acomment Comment
highlight link url Boolean
highlight link quote String


let b:current_syntax = "iim"
