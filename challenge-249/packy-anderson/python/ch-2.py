#!/usr/bin/env python

def diStringMatch(str):
    permutation = []
    # first, generate the list of integers
    # we're making permutations of
    nums = list(range(len(str)+1))
    # now let's generate our permutation
    for c in str:
        if c == 'D':
            # take the largest number available
            permutation.append( nums.pop(-1) )
        else:
            # take the smallest number available
            permutation.append( nums.pop(0) )
    # add last remaining number
    permutation.append( nums[0] )

    return permutation

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(str):
    print(f'Input: $str = ({comma_join(str)})')
    permutations = diStringMatch(str)
    print(f'Output: ({comma_join(permutations)})')

print('Example 1:')
solution("IDID")

print('\nExample 2:')
solution("III")

print('\nExample 3:')
solution("DDI")