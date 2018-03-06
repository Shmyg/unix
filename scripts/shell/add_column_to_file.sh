#!/usr/local/bin/bash
declare -i line_number
line_number=1
while read line
do
 tail -$line_number data2.txt > file$$.txt
 read line1 < file$$.txt 
 echo $line $line1
 line_number=line_number+1
done < data1.txt    
