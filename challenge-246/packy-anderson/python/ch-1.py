#!/usr/bin/env python

from random import sample

def sixOutOfFourtyNine():
    return sorted(sample(range(1, 49), 6))

def solution():
    arr = sixOutOfFourtyNine()
    print( "\n".join(map(str, arr)) )

print('Output')
solution()
