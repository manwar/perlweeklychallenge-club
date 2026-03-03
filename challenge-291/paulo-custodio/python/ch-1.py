#!/usr/bin/env python3

import sys

def middle_index(n):
    for i in range(len(n)):
        s1 = sum(n[0:i])
        s2 = sum(n[i+1:])
        if s1 == s2:
            return i
    return -1

print(middle_index(list(map(int, sys.argv[1:]))))
