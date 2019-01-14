#!/bin/sh
a=8
while [ $a -ne 200  ]
do
    a=$((a+1))

    echo "cp 8.png ${a}.png"
done
