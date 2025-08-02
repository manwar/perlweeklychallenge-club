#!/usr/bin/env python

import sys
from collections import Counter

def oddChar(s, t):
    # count the characters in s
    count = Counter()
    for c in s.lower():
        count[c] += 1

    # find the character in t that's been added to s
    for c in t.lower():
        if c not in count:
            # we found the added character!
            return c
        count[c] -= 1
        if count[c] == 0:
            del count[c]

    sys.exit("No odd character found!")

def solution(s, t):
    print(f'Input: $s = "{s}" $t = "{t}"')
    o = oddChar(s, t)
    print(f'Output: "{o}"')

print('Example 1:')
solution("Perl", "Preel")

print('\nExample 2:')
solution("Weekly", "Weeakly")

print('\nExample 3:')
solution("Box", "Boxy")