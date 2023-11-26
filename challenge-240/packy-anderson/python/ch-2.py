#!/usr/bin/env python

def buildArray(old):
    new = []
    for i in range(0, len(old)):
        new.append(old[old[i]])
    return new

def solution(ints):
    as_list = ', '.join(map(lambda i: str(i), ints))
    print(f'Input: @int = ({as_list})')
    output = buildArray(ints)
    as_list = ', '.join(map(lambda i: str(i), output))
    print(f'Output: ({as_list})')

print('Example 1:')
solution([0, 2, 1, 5, 3, 4])

print('\nExample 2:')
solution([5, 0, 1, 2, 3, 4])