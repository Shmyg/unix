#!/usr/local/bin/bash

#***********************************************************************#
# NAME
#       
#
# SYNOPSIS
#       
#
# DESCRIPTION
#	Not adding all 0 - should be added
# AUTHOR
#       
# HISTORY OF CHANGES
#	$Log: conv.sh,v $
#	Revision 1.1  2017/07/14 13:01:20  shmyg
#	Merged with shmyg_mis
#
#	Revision 1.1  2004/11/22 11:10:23  serge
#	*** empty log message ***
#
#
#***********************************************************************#

trap "exit 1" 0 1 2 15
: <<COMMENTBLOCK
factorial=1
n=$1
until [ "$n" -eq "1" ]
do
 (( factorial = factorial * n ))
 let "n--"
done
echo $factorial
COMMENTBLOCK
string_to_pad=00000000000000
convert_ternary () {
out_string=""
divisor=3
dividend=$1
until [ "$dividend" -lt "3" ]
do
 let "remainder = $dividend / $divisor"
 let "modulus = $dividend % $divisor"
 dividend=$remainder
 out_string=$modulus$out_string
done
final_value=$string_to_pad$dividend$out_string
string_len=${#final_value}
echo ${final_value:$string_len-$matches_num:$matches_num}
}

n=$1
(( matches_num = n * ( n - 1 ) ))
echo $matches_num
let "possible_vars = 3 ** $matches_num - 1"
until [ "$possible_vars" -eq "0" ]
do
 echo -en "$possible_vars\t"
 convert_ternary $possible_vars
 let "possible_vars--"
done
exit 0
