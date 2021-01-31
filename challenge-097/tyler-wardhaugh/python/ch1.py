#!/usr/bin/env python3
"""Challenge 97, Task 1"""

import string
import sys


DEFAULT_INPUT = ('THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG', 3)
ALPHABET = [ord(c) for c in string.ascii_uppercase]
ALEN = len(ALPHABET)

def caesar(s, n):
    aleph = ALPHABET[0]
    def f(oc):
        newoc = oc - n
        return newoc if newoc >= aleph else newoc + ALEN

    cipher = {oc: f(oc) for oc in ALPHABET}
    return s.translate(cipher)


def main(args=None):
    """Run the task"""
    if args is None:
        args = sys.argv[1:]

    s, n = args[0:1] if args else DEFAULT_INPUT
    print(caesar(s, n))


if __name__ == '__main__':
    sys.exit(main())
