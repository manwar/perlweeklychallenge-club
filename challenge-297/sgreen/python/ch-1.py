#!/usr/bin/env python3

import sys


def contiguous_array(binary: list) -> str:
    # Check that we have only zeros and ones
    if any(i not in (0, 1) for i in binary):
        raise ValueError('Only zeros and ones are allowed!')

    # The maximum length is the largest even number <= length of the array
    max_length = len(binary)
    if max_length % 2:
        max_length -= 1

    # Try the longest length first
    for length in range(max_length, 0, -2):
        # Check if any string matches the criteria
        for start in range(len(binary) - length + 1):
            # The criteria is met if the sum of the 1s and 0s is half the length
            if sum(binary[start:start+length+1]) == length // 2:
                return length

    return 0


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = contiguous_array(array)
    print(result)


if __name__ == '__main__':
    main()
