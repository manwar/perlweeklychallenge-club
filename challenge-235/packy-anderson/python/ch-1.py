#!/usr/bin/env python

def isStrictlyIncreasing(ints):
    intlist = ", ".join([ str(i) for i in ints ])
    # get the first integer from the list
    last_int = ints[0]

    for this_int in ints[1:]:
        if this_int <= last_int:
            return False
        last_int = this_int
    return True

def isStrictlyIncreasingExceptOne(ints):
    # the list cannot be strictly increasing unless
    # there are at least two items in it
    if len(ints) <= 1:
        return False

    # if it's strictly increasing without removing
    # an item, it fails the test
    if isStrictlyIncreasing(ints):
        return False

    length = len(ints)
    for i in range(1, length-1):
        if ints[i] <= ints[i - 1]:
            print(f'removed {ints[i - 1]} at {i-1}')
            ints.pop(i - 1)
            return isStrictlyIncreasing(ints)

def solution(ints):
    intlist = ", ".join([ str(i) for i in ints ])
    print(f'Input: @ints = ({ intlist })')
    output = isStrictlyIncreasingExceptOne(ints)
    print(f'Output: {output}')
 
print("Example 1:")
solution([0, 2, 9, 4, 6])
 
print("\nExample 2:")
solution([5, 1, 3, 2])

print("\nExample 3:")
solution([2, 2, 3])

print("\nExample 4 from James Curtis-Smith:")
solution([1,2,3,4,1,2,3])