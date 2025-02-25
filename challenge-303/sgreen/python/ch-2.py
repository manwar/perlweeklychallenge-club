#!/usr/bin/env python3

import sys
from collections import Counter


def score(freq: Counter) -> int:
    """Find the maximum points were can earn from the specified dictionary.

    Args:
        freq (Counter): The frequency of integers remaining.

    Returns:
        int: The maximum points that can be scored.
    """

    max_points = None

    # Work through each frequency.
    for i in freq:
        # Start with the points for using this integers.
        points = i

        # Delete the frequency one less and one more than `i`.
        new_freq = freq.copy()
        if i - 1 in new_freq:
            del new_freq[i-1]
        if i + 1 in new_freq:
            del new_freq[i+1]

        # Also remove one from this frequency, and delete if it is now zero.
        new_freq[i] -= 1
        if new_freq[i] == 0:
            del new_freq[i]

        # If there is something left, call the function again.
        if new_freq:
            points += score(new_freq)

        # Update max_points if required.
        if max_points is None or max_points < points:
            max_points = points

    return max_points


def delete_and_earn(ints: list) -> int:
    # Turn the list into a frequency dictionary and find the maximum points
    freq = Counter(ints)
    return score(freq)


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = delete_and_earn(array)
    print(result)


if __name__ == '__main__':
    main()
