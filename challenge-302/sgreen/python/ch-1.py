#!/usr/bin/env python3

from itertools import combinations
import sys


def ones_and_zeros(s: list, max_zeros: int, max_ones: int) -> int:
    # Consider all lengths of subsets, largest first
    for length in range(len(s), 0, -1):
        # Compute all subsets of this length
        for subset in combinations(s, length):
            # Combine the strings to a single string
            bits = ''.join(subset)
            if bits.count('0') <= max_zeros and bits.count('1') <= max_ones:
                # We have found the largest subset
                return length

    # Nothing matches
    return 0


def main():
    result = ones_and_zeros(
        sys.argv[1:-2], int(sys.argv[-2]), int(sys.argv[-2])
    )
    print(result)


if __name__ == '__main__':
    main()
