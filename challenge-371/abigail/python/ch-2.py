#!/opt/homebrew/bin/python3

import sys

for line in sys . stdin:
    numbers = list (map (lambda n: int (n), line . strip () . split (" ")))

    for mask in range (1, 2 ** (len (numbers)) - 1):
        sum = 0
        set = []
        for index, val in enumerate (numbers):
            if mask & (1 << index):
                sum = sum + val - index - 1
                set . append (val)
        if sum == 0 and len (set) > 1:
            for i, val in enumerate (set):
                print (val, end = '')
                if i == len (set) - 1:
                    print (";", end = '')
                print (" ", end = '')
    print ("")
