#!/opt/homebrew/bin/python3

import sys

for n in sys . stdin:
    sf = 1
    for i in range (1, int (n) + 1):
        sf = i * sf + 1 - 2 * (i % 2)
    print (sf)
