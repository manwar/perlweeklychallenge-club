#!/usr/bin/env python3

# Challenge 051
#
# TASK #2
# Colourful Number
# Write a script to display all Colorful Number with 3 digits.
#
# A number can be declare Colorful Number where all the products of consecutive
# subsets of digit are different.
#
# For example, 263 is a Colorful Number since 2, 6, 3, 2x6, 6x3, 2x6x3 are
# unique.

def uniq(mylist):
    return list(dict.fromkeys(mylist))

def colorful():
    out = []
    for a in range (1, 10):
        for b in range(10):
            for c in range(10):
                prods = [a, b, c, a*b, b*c, a*b*c]
                if len(uniq(prods)) == 6:
                    out.append(a*100+b*10+c)
    return out

print(", ".join([str(x) for x in colorful()]))
