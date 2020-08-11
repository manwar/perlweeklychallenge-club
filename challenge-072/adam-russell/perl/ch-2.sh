perl -s -n -e 'print if $. >= $A && $. <= $B' -- -A=4 -B=12  < input.txt
