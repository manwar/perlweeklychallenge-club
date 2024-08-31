#!/usr/bin/env python3

# Challenge 047
#
# TASK #2
# Gapful Number
# Write a script to print first 20 Gapful Numbers greater than or equal to 100.
# Please check out the page for more information about Gapful Numbers.

def is_gapful(n):
    n1 = int(str(n)[0])
    n2 = int(str(n)[-1])
    div =  n1*10+n2
    return n % div == 0

out = []
n = 100
while len(out) < 20:
    if is_gapful(n):
        out.append(n)
    n += 1
print(", ".join([str(x) for x in out]))
