#!/usr/bin/env python

def multiplyByTwo(ints, start):
    intSet = frozenset(ints)
    explain = []
    step = 0

    while start in intSet:
        step += 1
        old = start
        start *= 2
        explain.append(
          f"Step {step}: {old} is in the array " +
          f"so {old} x 2 = {start}"
        )
    explain.append(
      f"{start} is not in the array so return {start}."
    )
    return (start, "\n".join(explain))

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(ints, start):
    print(f'Input: @ints = ({comma_join(ints)})', end=" ")
    print(f'and $start = {start}')
    (output, explain) = multiplyByTwo(ints, start)
    print(f'Output: {output}\n\n{explain}')

print('Example 1:')
solution([5,3,6,1,12], 3)

print('\nExample 2:')
solution([1,2,4,3], 1)

print('\nExample 3:')
solution([5,6,7], 2)