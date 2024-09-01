#!/usr/bin/env python3

from collections import Counter
import sys


def lucky_integer(ints: list) -> str:
    # Calculate the frequency of each integer
    freq = Counter(ints)

    # Work through the dict, highest first
    for i in sorted(freq, reverse=True):
        if i == freq[i]:
            # We have the lucky integer
            return i

    # There is no lucky integer
    return -1


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = lucky_integer(array)
    print(result)


if __name__ == '__main__':
    main()
