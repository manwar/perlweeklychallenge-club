#!/usr/bin/env python3

import sys


def main(array):
    # Convert the input into numbers
    nums = [int(x) for x in array]

    # Take the last value as 'k'
    k = nums.pop()
    matches = 0

    for i in range(len(array)-2):
        for j in range(i+1, len(array)-1):
            if (nums[i] + nums[j]) % k == 0:
                matches += 1

    print(matches)


if __name__ == '__main__':
    main(sys.argv[1:])
