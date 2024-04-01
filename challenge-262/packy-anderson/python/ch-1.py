#!/usr/bin/env python

def maxPosNeg(ints):
    pos = sum([1 for i in ints if i > 0])
    neg = sum([1 for i in ints if i < 0])
    maxCount = max(pos, neg)
    return (
      maxCount,
      "\n".join([
          f"Count of positive integers: {pos}",
          f"Count of negative integers: {neg}",
          f"Maximum of count of positive and " +
          f"negative integers: {maxCount}"
      ])
    )

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
    print(f'Input: @arr = ({comma_join(ints)})')
    (maxCount, explain) = maxPosNeg(ints)
    print(f'Output: {maxCount}\n\n{explain}')

print('Example 1:')
solution([-3, 1, 2, -1, 3, -2, 4])

print('\nExample 2:')
solution([-1, -2, -3, 1])

print('\nExample 3:')
solution([1,2])