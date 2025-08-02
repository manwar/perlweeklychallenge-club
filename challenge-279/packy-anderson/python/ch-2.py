#!/usr/bin/env python

vowels = ['a', 'e', 'i', 'o', 'u']

def splitString(str):
    return len([
        v for v in list(str.lower()) if v in vowels
    ]) % 2 == 0

def solution(str):
    print(f'Input: @str = "{str}"')
    print(f'Output: {splitString(str)}')

print('Example 1:')
solution("perl")

print('\nExample 2:')
solution("book")

print('\nExample 3:')
solution("good morning")
