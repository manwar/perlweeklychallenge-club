#!/usr/bin/env python

import re

def sortString(str):
    words = {}
    for w in str.split():
        m = re.search('(?P<word>\D+)(?P<order>\d+)', w)
        words[m.group('order')] = m.group('word')
    
    return (' '.join([
        words[k] for k in sorted(words.keys(), key=int)
    ]))

def solution(str):
    print(f'Input: $str = "{str}"')
    print(f'Output: "{sortString(str)}"')

print('Example 1:')
solution("and2 Raku3 cousins5 Perl1 are4")

print('\nExample 2:')
solution("guest6 Python1 most4 the3 popular5 is2 language7")

print('\nExample 3:')
solution("Challenge3 The1 Weekly2")

print('\nExample 4:')
solution("The1 brown9 dog10 fox4 jumped5 lazy8 over6 quick2 red3 the7")
