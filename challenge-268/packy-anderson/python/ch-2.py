#!/usr/bin/env python

def numberGame(ints):
    intSorted = sorted(ints)
    new = []
    while intSorted:
        x = intSorted.pop(0)
        y = intSorted.pop(0)
        if x > y:
            new.extend([x, y])
        else:
            new.extend([y, x])
    return new

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
    print(f'Input: @ints = ({comma_join(ints)})')
    new = numberGame(ints)
    print(f'Output: ({comma_join(new)})')

print('Example 1:')
solution([2, 5, 3, 4])

print('\nExample 2:')
solution([9, 4, 1, 3, 6, 4, 6, 1])

print('\nExample 3:')
solution([1, 2, 2, 3])