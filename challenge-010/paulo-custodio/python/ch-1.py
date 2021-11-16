#!/usr/bin/python3

# Challenge 010
#
# Challenge #1
# Write a script to encode/decode Roman numerals. For example, given Roman
# numeral CCXLVI, it should return 246. Similarly, for decimal number 39, it
# should return XXXIX. Checkout wikipedia page for more information.

import sys
import roman

if len(sys.argv)==2:
    if sys.argv[1]=="-test":
        for i in range(1, 3001):
            s = roman.toRoman(i)
            n = roman.fromRoman(s)
            if i!=n:
                print(f"{i} => {s} => {n}")
                sys.exit(1)
    elif sys.argv[1].isdigit():
        n = int(sys.argv[1])
        s = roman.toRoman(n)
        print(f"{n} => {s}")
    else:
        s = sys.argv[1]
        n = roman.fromRoman(s)
        print(f"{s} => {n}")
