#! /bin/bash

path="/home/mego/Desktop/rx_poc.log"

c=$(wc -l $path | awk '{print $1}')
if (( $c <= 2 )); then
echo 'Data is not enough for this operation !!'
else 
#echo $c
echo -e "year\tmonth\tday\tobs_temp\tfc_temp\taccuracy\taccuracy_range" > historical_fc_accuracy.tsv
for i in $(seq 3 $c); do 

	my_indx=$(( i - 1 ))
	record_2day=$(sed -n "${i}p" "$path")
	record_yday=$(sed -n "${my_indx}p" "$path")
	op_2day=$(echo $record_2day | awk '{print $4}')
	fc_2day=$(echo $record_yday | awk '{print $5}')

	diff=$(( $op_2day - $fc_2day ))
	the_accuercy="a"

	if [ $diff -ge -1 ] && [ $diff -le 1 ] ; then 
	the_accuercy="EXCELLENT"
	range='+/-1'
	elif [ $diff -ge -2 ] && [ $diff -le 2 ] ; then 
	the_accuercy="GOOD"
	range='+/-2'
	elif [ $diff -ge -3 ] && [ $diff -le 3 ] ; then 
	the_accuercy="FAIR"
	range='+/-3'
	else
	the_accuercy="POOR"
	range='+/-4'
	fi
        
        c_day=$(echo $record_2day | awk '{print $3}')
	
	c_month=$(echo $record_2day | awk '{print $2}')
	
	c_year=$(echo $record_2day | awk '{print $1}')

	echo -e "$c_year\t$c_month\t$c_day\t$op_2day\t\t$the_accuercy\t\t\t$range" >> historical_fc_accuracy.tsv
	#echo "$diff forcast accuercy for day $i is $the_accuercy" 
	
done
fi

