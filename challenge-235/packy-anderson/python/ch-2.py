#!/usr/bin/env python

def duplicateZeros(ints):
    length = len(ints)
    skip_me = -1
    for i in range(0, length):
        if skip_me == i:
            continue
        if ints[i] == 0:
            ints.insert(i+1, 0) # insert a 0 at i+1
            ints.pop(-1)        # pop the last element off ints
            skip_me = i+1       # skip over the 0 we added!
    return ints

def solution(ints):
    intlist = ", ".join([ str(i) for i in ints ])
    print(f'Input: @ints = ({ intlist })')
    ints = duplicateZeros(ints)
    intlist = ", ".join([ str(i) for i in ints ])
    print(f'Output: ({ intlist })');
 
print("Example 1:")
solution([1, 0, 2, 3, 0, 4, 5, 0])
 
print("\nExample 2:")
solution([1, 2, 3])
 
print("\nExample 3:")
solution([0, 3, 0, 4, 5])