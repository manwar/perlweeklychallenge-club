#!/usr/bin/env python

import re

def consistentCount(allowed, str):
    regex = re.compile('^[' + allowed + ']+$')
    count = 0
    for s in str:
        if regex.match(s):
            count += 1
    return count

def solution(allowed, str):
    as_list = '"' + '", "'.join(str) + '"'
    print(f'Input: @str = ({as_list})')
    print(f'       $allowed = "{allowed}"')
    output = consistentCount(allowed, str)
    print(f'Output: {output}')

print('Example 1:')
solution("ab", ["ad", "bd", "aaab", "baa", "badab"])

print('\nExample 2:')
solution("abc", ["a", "b", "c", "ab", "ac", "bc", "abc"])

print('\nExample 3:')
solution("cad", ["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"])