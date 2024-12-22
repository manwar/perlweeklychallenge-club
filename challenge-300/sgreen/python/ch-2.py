#!/usr/bin/env python3

import sys


def nested_array(ints: list) -> int:
    longest_set = 0

    for start in range(len(ints)):
        # Keep track of items we've used
        this_set = [ints[start]]

        # Keep adding to the set until we we hit an already used number
        while ints[this_set[-1]] not in this_set:
            this_set.append(ints[this_set[-1]])

        # If the set is longer than previous ones found, update it.
        if longest_set < len(this_set):
            longest_set = len(this_set)

    return longest_set


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = nested_array(array)
    print(result)


if __name__ == '__main__':
    main()
