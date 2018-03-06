#!/usr/local/bin/bash

exec 3</home/serge/tmp/data1.txt

while read line <&3
do
 echo $line 0
done

exec 3<&-
exit 0
