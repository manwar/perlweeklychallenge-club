#!/usr/bin/env python

from collections import Counter

def equalPairs(nums):
    pairs = []
    num_count = Counter()
    # count how many of each int we have
    for num in nums:
        num_count[num] += 1

    # first, make sure we have even numbers of each integer
    for k, v in dict(num_count).items():
        if v % 2 == 0: # it's even, we can make pairs
            continue
        else:
            return pairs # we have an odd number, no pairs

    # now make pairs from those integers
    for k, v in dict(num_count).items():
        count = v # the values k, v are read-only
        while count > 0:
            pairs.append( [k, k] )
            count -= 2

    return pairs

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(nums):
    print(f'Input: @ints = ({comma_join(nums)})')
    pairs = equalPairs(nums)
    if len(pairs) == 0:
        print('Output: ()')
    else:
        pairs = [ f'({x[0]}, {x[1]})' for x in pairs ]
        print(f"Output: { ', '.join(pairs) }")

print('Example 1:')
solution([3, 2, 3, 2, 2, 2])

print('\nExample 2:')
solution([1, 2, 3, 4])

print('\nExample 3:')
solution([1, 2, 3, 4, 4, 3, 2, 1])