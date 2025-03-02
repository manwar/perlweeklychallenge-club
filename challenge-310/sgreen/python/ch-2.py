#!/usr/bin/env python3

import sys


def sort_odd_even(ints: list) -> list:
    # Sort the even and odd elements
    even_elements = sorted(ints[::2])
    odd_elements = sorted(ints[1::2], reverse=True)

    # Pair the matching even and odd elements
    solution = []
    for idx in range(len(odd_elements)):
        solution.append(even_elements[idx])
        solution.append(odd_elements[idx])

    if len(ints) % 2 == 1:
        # Add the last even value if the list is odd.
        solution.append(even_elements[-1])

    return solution


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = sort_odd_even(array)
    print(result)


if __name__ == '__main__':
    main()
