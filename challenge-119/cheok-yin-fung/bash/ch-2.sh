#!/bin/bash
# The Weekly Challenge - 119 
# Task 2 Sequence without 1-on-1
# Usage: $ chmod +x ch-2.sh
#        $ ./ch-2.sh N

N=$1
arr=(0 1 2 3)

x=0
y=0
while [ ${#arr[@]} -lt $N ]
do
    y=${#arr[@]}
    for ((h=$x+1; $h<=$y; h=$h+1))
    do 
        if [ $(($[arr[$h]] % 10)) -ne 1 ] ; 
            then arr+=($[arr[$h]]*10+1) ; 
        fi
        arr+=($[arr[$h]]*10+2)
        arr+=($[arr[$h]]*10+3) 
    done
    x=$y
done

echo $[arr[$N]]

# ref:
# https://stackoverflow.com/questions/19417015/how-to-copy-an-array-in-bash
# https://linuxhandbook.com/bash-arrays/
# http://rosettacode.org/wiki/Loops/For_with_a_specified_step#Bourne_Shell
# Bash Guide for Beginners
# Classic Shell Scripting

