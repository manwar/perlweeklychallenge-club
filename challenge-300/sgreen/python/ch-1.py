#!/usr/bin/env python3

import sys
from itertools import permutations


def beautiful_arrangement(n: list) -> str:
    count = 0

    # Calculate all permutations
    for p in permutations(range(1, n+1)):
        for i in range(n):
            if p[i] % (i+1) != 0 and (i+1) % p[i] != 0:
                break
        else:
            # We have a beautiful arrangement, add to the counter.
            count += 1

    return count


def main():
    # Convert input into integers
    i = int(sys.argv[1])
    result = beautiful_arrangement(i)
    print(result)


if __name__ == '__main__':
    main()
