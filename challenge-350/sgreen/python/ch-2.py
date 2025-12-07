#!/usr/bin/env python3

import sys


def is_shuffle_pair(a: int, b: int) -> bool:
    return sorted(str(a)) == sorted(str(b))


def shuffle_pairs(start: int, stop: int, count: int) -> int:
    """
    Count how many numbers in the range [start, stop] have at least 'count'
    shuffle pairs.

    Args:
        start (int): The start of the range (inclusive).
        stop (int): The end of the range (inclusive).
        count (int): The minimum number of shuffle pairs required.

    Returns:
        int: The count of numbers with at least 'count' shuffle pairs.
    """
    shuffle_pairs = 0

    for value in range(start, stop + 1):
        # Count how many shuffle pairs this value has
        this_count = 0

        # Start checking multiples of the value
        multiplier = 2
        while True:
            candidate = value * multiplier
            if candidate >= 10 ** len(str(value)):
                # There are no more candidates that could be shuffle pairs
                break
            if is_shuffle_pair(value, candidate):
                # Check if the candidate is a shuffle pair (same digits as
                #  value, but a different order)
                this_count += 1

            # Increment multiplier for next candidate
            multiplier += 1

        # If this value has enough shuffle pairs, increment the global count
        if this_count >= count:
            shuffle_pairs += 1

    return shuffle_pairs


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = shuffle_pairs(*array)
    print(result)


if __name__ == '__main__':
    main()
