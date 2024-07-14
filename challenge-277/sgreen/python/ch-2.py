#!/usr/bin/env python3

import sys


def strong_pair(ints: list) -> int:
    # Remove duplicates
    ints = list(set(ints))
    count = 0

    for i in range(len(ints)-1):
        for j in range(i+1, len(ints)):
            if abs(ints[i]-ints[j]) < min(ints[i], ints[j]):
                count += 1

    return count


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = strong_pair(array)
    print(result)


if __name__ == '__main__':
    main()
