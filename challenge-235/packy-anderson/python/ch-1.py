#!/usr/bin/env python

def isStrictlyIncreasingExceptOne(ints):
    # the list cannot be strictly increasing unless
    # there are at least two items in it
    if len(ints) <= 1:
        return False

    count = 0 # track how many exceptions

    # get the first integer from the list
    last_int = ints.pop(0)

    for this_int in ints:
        if this_int <= last_int:
            count += 1
            if count > 1:
                # if we have encountered more than one
                # case where the current int is less than
                # or equal to the last int, we can bail
                # out early, because the check fails
                return False

        # move the current int to the last int
        last_int = this_int

    # if the count of cases where the list
    # wasn't increasing is equal to one,
    # then we return true, otherwise false
    return count == 1


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