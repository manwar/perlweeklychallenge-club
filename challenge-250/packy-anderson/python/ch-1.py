#!/usr/bin/env python

def smallestIndex(ints):
    for i in range(len(ints)):
        if (i % 10) == ints[i]:
            return i
    return -1

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
    print(f'Input: @ints = ({comma_join(ints)})')
    smallest = smallestIndex(ints)
    print(f'Output: {smallest}')

print('Example 1:')
solution([0, 1, 2])

print('\nExample 2:')
solution([4, 3, 2, 1])

print('\nExample 3:')
solution([1, 2, 3, 4, 5, 6, 7, 8, 9, 0])