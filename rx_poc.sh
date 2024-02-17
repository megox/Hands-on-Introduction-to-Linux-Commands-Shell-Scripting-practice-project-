#!/bin/bash

city="Cairo"

#get the wether from wttr
curl -s wttr.in/$city?T | grep -m 2 '°.' | grep -Eo  "\+?([0-9]{2})(\([0-9]{2}\))?\s.C"  | awk '{print $1}' | cut -d '(' -f1 > out.txt
#cat out.txt
#assign tmp into shell vaiables
op_tmp=$(sed -n 1p out.txt)

fc_tmp=$(sed -n 3p out.txt)

#Current time 
c_day=$(date +%d)

c_month=$(date +%m)

c_year=$(date +%y)

#new record
echo -e "$c_year\t$c_month\t$c_day\t$op_tmp\t\t$fc_tmp" >> rx_poc.log


