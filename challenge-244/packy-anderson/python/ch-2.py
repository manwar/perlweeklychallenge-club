#!/usr/bin/env python

from itertools import combinations

def power(arr):
    return( (max(arr) ** 2) * min(arr) )

def groupHero(nums):
    # generate a list of combinations
    comb = []
    for i in range(1, len(nums)+1):
        for c in combinations(nums, i):
            comb.append(c)
    return sum(
      # generate the list of powers for each combination
      [ power(x) for x in comb ]
    )

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(arr):
    print(f'Input: @int = ({comma_join(arr)})')
    output = groupHero(arr)
    print(f'Output: {output}')

print('Example 1:')
solution([2, 1, 4])
