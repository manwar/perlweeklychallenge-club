#!/opt/homebrew/bin/python3

import sys

for line in sys . stdin:
    sum = 0
    i   = 0
    for ch in line:
        i = i + 1
        if "a" <= ch and ch <= "z":
            sum = sum + i * (ord ("z") - ord (ch) + 1)
    print (sum)

