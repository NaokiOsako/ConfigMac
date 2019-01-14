#!/bin/sh
a=0
while [ $a -ne 700000  ]
do
    a=$((a+1000))
    sed -n '/| Total On-Chip Power (W)  |/p' report_power${a} >> totalpow.txt

done
