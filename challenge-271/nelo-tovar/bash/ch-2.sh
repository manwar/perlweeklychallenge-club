#!/usr/bin/env bash 
#
# The Weekly Challenge 271 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-271/
#
# Task 2 : Sort by 1 bits

function one_count() {
    local ones=$(bc <<< "obase=2;$1")
    ones=${ones//0/}

    echo ${#ones}
}

function sort_by_1_bits() {
    local nums=("$@")
    local n=${#nums[@]}

	for (( i = 0; i < $n-1; i++ )); do
		flag=0;
		for ((j = 0; j < $n-1-$i; j++ )); do
            a=$(one_count ${nums[$j]})
            b=$(one_count ${nums[$j+1]})
            swap=0
			if [[ $a -gt $b ]]; then
			    swap=1
			elif [ $a -eq $b ] && [ ${nums[$j]} -gt ${nums[$j+1]} ]; then
			    swap=1
			fi
			if [ $swap -eq 1 ]; then
				temp=${nums[$j]};
				nums[$j]=${nums[$j+1]};
				nums[$j+1]=$temp;
				flag=1;
			fi
		done

		if [[ $flag -eq 0 ]]; then
			  break;
		fi
    done

    echo ${nums[@]}
}

examples=('0 1 2 3 4 5 6 7 8 9' '1024 512 256 128 64')

for e in ${!examples[@]}; do
    array=(${examples[$e]})
    sbb=$(sort_by_1_bits "${array[@]}")
    echo "Input  : nums = (${array[@]})"
    echo -e "Output : $sbb\n"
done

