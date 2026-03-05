#!/usr/bin/env python3

import sys

def double_letter(s):
    found = {}
    for char in s:
        if char in found:
            return char
        found[char] = True
    return ""

print(double_letter(sys.argv[1]))
