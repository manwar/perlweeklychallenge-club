#!/opt/homebrew/bin/python3

import sys

for line in sys . stdin:
    parts = line . strip () . split (" ")
    base  = int (parts [0])
    limit = int (parts [1])
    for n in range (0, limit + 1):
        size = 0
        n_c = n
        while n_c > 0:
            size = size + 1
            n_c  = n_c // base
        sum = 0
        n_c = n
        while n_c > 0:
            sum = sum + (n_c % base) ** size
            n_c = n_c // base
        if sum == n:
            print (n, end = ' ')
    print ("")
