#!/usr/bin/env python

def mergeStrings(str1, str2):
    chars1 = list(str1)
    chars2 = list(str2)
    result = ''
    while chars1 or chars2:
        if chars1:
            result += chars1.pop(0)
        if chars2:
            result += chars2.pop(0)
    return result

def solution(str1, str2):
    print(f'Input: $str1 = "{str1}", $str2 = "{str2}"')
    output = mergeStrings(str1, str2)
    print(f'Output: {output}')

print('Example 1:')
solution("abcd", "1234")

print('\nExample 2:')
solution("abc", "12345")