#
# The Weekly Challenge 252 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-252/
#
# Task 2 : Unique Sum Zero

function unique_sum_zero() {
    local n=$1
    local numbers=()

    if [[ $(($n % 2)) -ne 0 || $n -eq 1 ]]; then
        numbers=(0)
    fi

    for (( k = 1; k <= $(($n / 2)); k++ )); do
        i=$(shuf -i 1-10 -n 1)
        numbers+=($i -$i)
    done

    echo ${numbers[@]}
}

example1='5 3 1'

for e in $example1; do
    array=($e)
    usz=$(unique_sum_zero $e)
    echo "Input  : $s = $e"
    echo "Output :" $(printf " %s, " ${usz[@]})
    echo  " "
done

