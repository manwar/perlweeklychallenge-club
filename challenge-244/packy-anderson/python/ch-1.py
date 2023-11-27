#!/usr/bin/env python

def countSmaller(arr):
    counts = []
    for i, i_val in enumerate(arr):
        counts.append(0)
        for j, j_val in enumerate(arr):
            if j_val < i_val:
                counts[i] += 1
    return counts

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(arr):
    print(f'Input: @int = ({comma_join(arr)})')
    output = countSmaller(arr)
    print(f'Output: ({comma_join(output)})')

print('Example 1:')
solution([8, 1, 2, 2, 3])

print('\nExample 2:')
solution([6, 5, 4, 8])

print('\nExample 3:')
solution([2, 2, 2])
