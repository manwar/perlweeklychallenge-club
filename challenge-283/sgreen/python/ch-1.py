#!/usr/bin/env python3

from collections import Counter
import sys


def unique_number(ints: list) -> int:
    # Calculate the frequency of each integer
    freq = Counter(ints)

    # Get the integers that appear only once
    only_once = [i for i in freq if freq[i] == 1]

    if len(only_once) == 1:
        return only_once[0]

    if len(only_once) == 0:
        raise ValueError('No values only appear once')

    raise ValueError('More than one value appears once')


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = unique_number(array)
    print(result)


if __name__ == '__main__':
    main()
