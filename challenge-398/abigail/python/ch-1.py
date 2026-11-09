#!/opt/homebrew/bin/python3

import sys

for line in sys . stdin:
    numbers = list (map (lambda x: int (x), line . strip () . split ()))
    sum   = 0
    count = 0
    for number in numbers:
        if number % 6 == 0:
            sum   = sum + number
            count = count + 1

    res = 0
    if sum != 0:
        res = round (sum / count)
    print (res)
