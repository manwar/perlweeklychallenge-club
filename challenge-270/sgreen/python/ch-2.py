#!/usr/bin/env python3

import sys


def equalize_array(ints: list, x: int, y: int) -> str:
    score = 0
    # Calculate the needed values
    max_value = max(ints)
    needed = [max_value - i for i in ints]

    # If we have at least two items, and y is less than 2 × x, lets remove two
    #  values at a time while we can
    if len(ints) > 1 and y < x * 2:
        while True:
            # Sort the positions by the values they hold
            sorted_index = sorted(
                range(len(ints)),
                key=lambda index: needed[index],
                reverse=True
            )

            # If we don't have two non zero values, we are done with level 2
            if needed[sorted_index[1]] == 0:
                break

            # Take one off each number at that position
            needed[sorted_index[0]] -= 1
            needed[sorted_index[1]] -= 1
            score += y

    # As level one takes one off each number, we simply multiple the remaining
    #  needed values by the x value
    score += sum(needed) * x

    return score


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    y = array.pop()
    x = array.pop()
    result = equalize_array(array, x, y)
    print(result)


if __name__ == '__main__':
    main()
