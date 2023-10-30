#!/usr/bin/env python

def runningSum(int):
    sums = []
    running_sum = 0
    for num in int:
        # add the next number to the sum of numbers before it
        running_sum += num
        # add the current running sum to the output array
        sums.append( running_sum )
    return sums

def solution(int):
    as_list = ', '.join(map(lambda i: str(i), int))
    print(f'Input: @int = ({as_list})')
    sums = runningSum(int)
    as_list = ', '.join(map(lambda i: str(i), sums))
    print(f'Output: ({as_list})')

print('Example 1:')
solution([1, 2, 3, 4, 5])

print('\nExample 2:')
solution([1, 1, 1, 1, 1])

print('\nExample 3:')
solution([0, -1, 1, 2])