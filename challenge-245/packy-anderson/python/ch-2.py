#!/usr/bin/env python

from itertools import combinations

def largestOfThree(ints):
    # generate a list of combinations
    combos = [
        c for i in range(1, len(ints)+1)
          for c in combinations(ints, i)
    ]
    maxval = -1 # initialize our failure case
    for combo in combos:
        combo_list = list(combo)
        combo_list.sort(reverse=True)
        num = int(''.join(map(str, combo_list)))
        if num <= maxval: # not bigger than current max
            continue
        if num % 3 != 0: # not divisible by 3
            continue
        maxval = num
    return maxval

def comma_join(arr):
    return ', '.join(map(str, arr))

def solution(ints):
    print(f'Input: @arr = ({comma_join(ints)})')
    output = largestOfThree(ints)
    print(f'Output: {output}')

print('Example 1:')
solution([8, 1, 9])

print('\nExample 2:')
solution([8, 6, 7, 1, 0])

print('\nExample 3:')
solution([1])
