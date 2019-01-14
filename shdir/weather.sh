#!/bin/sh

w3m -dump http://weather.livedoor.com/forecast/rss/area/280010.xml | xsltproc --param showtitle "false()" ~/erss.xsl - | grep -v "^ *\\[ PR \\]" | head -n 5 | sed "s/- //g" | awk '{printf "%-12s %s %s(%s)\n",$7,$4,$5,$6}'

