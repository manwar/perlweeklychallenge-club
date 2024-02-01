#!/usr/bin/env python

def isAPowerOfThree(n, pow = 0):
    if n == pow ** 3:
        return 'true'
    elif n < pow ** 3:
        return 'false'
    return isAPowerOfThree(n, pow + 1)

def solution(n):
    print(f'Input: $n = {n}')
    print(f'Output: {isAPowerOfThree(n)}')

print('Example 1:')
solution(27)

print('\nExample 2:')
solution(0)

print('\nExample 3:')
solution(6)