#!/usr/bin/env python3

# Challenge 041
#
# TASK #2
# Write a script to display first 20 Leonardo Numbers. Please checkout wiki
# page for more information.
# For example:
#
# L(0) = 1
# L(1) = 1
# L(2) = L(0) + L(1) + 1 = 3
# L(3) = L(1) + L(2) + 1 = 5
# and so on.

def leonardo(n):
    if n < 2:
        return 1
    else:
        return leonardo(n-1)+leonardo(n-2)+1

out = []
for n in range(20):
    out.append(leonardo(n))
print(", ".join([str(x) for x in out]))
