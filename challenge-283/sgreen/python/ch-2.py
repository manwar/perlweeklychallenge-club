#!/usr/bin/env python3

from collections import Counter
import sys


def digit_count_value(ints: list) -> bool:
    # Calculate the frequency of each integer
    freq = Counter(ints)

    for idx, value in enumerate(ints):
        # Check the index only appear value number of times
        if freq[idx] != value:
            return False

    # Checks pass
    return True


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = digit_count_value(array)
    print('true' if result else 'false')


if __name__ == '__main__':
    main()
