#!/usr/bin/env python3

import sys


def last_element(ints: list) -> int:
    while len(ints) > 1:
        # Sort the list, and remove the last two elements
        ints.sort()
        x = ints.pop()
        y = ints.pop()

        if x != y:
            # If the last two elements, append the difference to the ints
            #  array. We know that x is greater than y, always.
            ints.append(x-y)

    return ints[0] if ints else 0


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = last_element(array)
    print(result)


if __name__ == '__main__':
    main()
