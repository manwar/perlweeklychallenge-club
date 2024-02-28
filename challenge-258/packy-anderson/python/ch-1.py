#!/usr/bin/env python

from math import floor, log10

def evenDigitCount(ints):
    count = 0; # in case there are no even digit ints
    for n in ints:
        if floor(log10(n) + 1) % 2 == 0: count += 1
    return count

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
    print(f'Input: @arr = ({comma_join(ints)})')
    print(f'Output: {evenDigitCount(ints)}')

print('Example 1:')
solution([10, 1, 111, 24, 1000])

print('\nExample 2:')
solution([111, 1, 11111])

print('\nExample 3:')
solution([2, 8, 1024, 256])
