#!/usr/bin/env python3

import sys


def get_degree(nums):
    '''Return the highest frequency of a set of numbers'''
    count = {}
    for i in nums:
        if i in count:
            count[i] += 1
        else:
            count[i] = 1

    return max(count.values())


def main(array):
    # Turn the list into an list of integers
    nums = [int(s) for s in array]
    degree = get_degree(nums)

    # Store the best thing found so far
    solution = None
    total = None

    for start in range(len(nums)-degree+1):
        for end in range(start+degree-1, len(nums)+1):
            value = nums[start:end]

            # Check if value has the same degree and is lower than the current
            #  value (or the current value is not)
            if get_degree(value) == degree \
                    and (total is None or sum(value) < total):

                # We have a new best solution
                solution = value
                total = sum(value)

    # Display the result
    print(*solution, sep=', ')


if __name__ == '__main__':
    main(sys.argv[1:])
