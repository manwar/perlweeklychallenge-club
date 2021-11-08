#!/usr/bin/env python

# run <script> <number>

import sys

def no1(nr):
    if len(nr)==0:
        return 0
    if nr[0] == '1':
        return 9**(len(nr)-1)
    return (int(nr[0])-1) * 9**(len(nr)-1) + no1(nr[1:])

print(no1(sys.argv[1]) if '1' not in sys.argv[1] else (no1(sys.argv[1])-1))
