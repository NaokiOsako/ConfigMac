#! /bin/sh
if [ $# -eq 0 ]
then
    echo ERROR: No input file.
else
    for arg in $@
    do
        echo INPUT: ${arg} ...
            platex `pwd`/$arg
            platex `pwd`/$arg 1>/dev/null
            dvipdfmx `pwd`/${arg%tex}dvi 1>/dev/null
            rm `pwd`/${arg%tex}aux `pwd`/${arg%tex}log `pwd`/${arg%tex}dvi
	    open `pwd`/${arg%tex}pdf
    done
fi



