#!/usr/bin/env python

import sys


def main(strings):
    # Convert to numbers
    nums = [float(x) for x in strings]
    sorted = 1

    for i in range(1, len(nums)):
        # If the value is less than the previous, the array is not sorted
        if nums[i] < nums[i - 1]:
            sorted = 0
            break

    print(f"{sorted}")


if __name__ == '__main__':
    main(sys.argv[1:])
