#!/opt/homebrew/bin/python3

import sys

for line in sys . stdin:
    numbers = list (map (lambda n: int (n), line . split ()))
    max = min = min_c = max_c = 0
    for number in numbers:
        if min_c == 0 or number < min: min_c = 0; min = number
        if max_c == 0 or number > max: max_c = 0; max = number
        if min == number: min_c = min_c + 1
        if max == number: max_c = max_c + 1
    if min == max:
        max_c = 0
    print (len (numbers) - min_c - max_c)
