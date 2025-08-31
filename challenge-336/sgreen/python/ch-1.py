#!/usr/bin/env python3

import sys
from collections import Counter

def equal_group(ints: list) -> bool:
    # Calculate the frequency of each integer in the list
    freq = Counter(ints).values()

    # If any integer appears only once, it is always false.
    if min(freq) == 1:
        return False

    # Check if all frequencies are evenly divisible by an integer.
    for i in range(2, max(freq) + 1):
        if all(f % i == 0 for f in freq):
            return True

    return False


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = equal_group(array)
    print(result)


if __name__ == '__main__':
    main()
