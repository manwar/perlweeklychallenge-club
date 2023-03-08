#!/bin/bash

# Define keyboard rows
row1="qwertyuiop"
row2="asdfghjkl"
row3="zxcvbnm"

# Read words from input array
words=("Hello" "Alaska" "Dad" "Peace")

# Iterate over each word
for word in "${words[@]}"
do
    # Check if all letters of the word belong to one keyboard row
    if grep -qi "^[${row1}]*\$\|^[${row2}]*\$\|^[${row3}]*\$" <<< "$word"; then
        # Print the word if it can be typed using only one row
        echo "$word"
    fi
done

