#!/usr/bin/env python

def concatenationValue(ints):
    if len(ints) == 0: # no elements
        return 0
    if len(ints) == 1: # one element
        return ints[0]

    first = ints.pop(0);  # first element
    last  = ints.pop(-1); # last element
    concat = int(f"{first}{last}") # concatenate and convert

    return concat + concatenationValue(ints)

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
    print(f'Input: @ints = ({comma_join(ints)})')
    value = concatenationValue(ints)
    print(f'Output: {value}')

print('Example 1:')
solution([6, 12, 25, 1])

print('\nExample 2:')
solution([10, 7, 31, 5, 2, 2])

print('\nExample 3:')
solution([1, 2, 10])
