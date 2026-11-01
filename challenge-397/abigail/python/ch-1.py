#!/opt/homebrew/bin/python3

import sys

def array_of_int (line):
    return list (map (lambda x: int (x), line . strip () . split ()))

for line in sys . stdin:
    numbers = array_of_int (line)
    numbers . sort ()
    sum = 0
    for num in numbers:
        sum = sum + num
    res = 1 + sum // len (numbers)
    if res <= 0:
        res = 1

    for num in numbers:
        if num == res:
            res = res + 1
        if num >  res:
            break

    print (res)
