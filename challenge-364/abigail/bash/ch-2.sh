#!/opt/homebrew/bin/bash

while read -r line
do  line=${line//()/o}        # Replace '()'   by '0',  globally
    line=${line//(al)/al}     # Replace '(al)' by 'al', globally
    echo $line
done

