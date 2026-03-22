#!/opt/homebrew/bin/python3

import sys
import re

#
# Return (as a string), the index of a given character, with 'a' being 1,
# and 'z' being 26.
#
def ch_to_index (match):
    char = match . group (0)
    if ord ('a') <= ord (char) <= ord ('z'):
        index = ord (char) - ord ('a') + 1
        return str (index)
    else:
        return char

#
# Given a number (as a string), calculate its sum, and return it, as a string
#
def digit_sum (str):
    ds = 0
    for ch in str:
        ds += int (ch)
    return "{}" . format (ds)  # Python doesn't like 'str (ds)' here

for line in sys . stdin:
    [word, count] = line . split ()
    #
    # Replace letters with the corresponding numbers
    #
    word = re . sub ('[a-z]', ch_to_index, word)

    #
    # Repeatedly replace the word with its digit sum
    #
    for i in range (int (count)):
        word = digit_sum (word)
    print (word)
