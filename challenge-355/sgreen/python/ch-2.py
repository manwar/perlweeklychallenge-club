#!/usr/bin/env python3

import sys


def mountain_array(ints: list) -> bool:
    """
    Determine if the given array is a 'mountain array'.

    Args:
        ints (list): List of integers representing the array.

    Returns:
        bool: True if the array is a mountain array, False otherwise.
    """
    if len(ints) < 3:
        return False

    direction = 'up'
    last_int = ints[0]

    if ints[1] <= last_int:
        # Ensure that we start by going up
        return False

    for current_int in ints[1:]:
        if current_int == last_int:
            return False
        if direction == 'up':
            if current_int < last_int:
                direction = 'down'
        else:  # direction == 'down'
            if current_int > last_int:
                return False

        last_int = current_int

    if direction == 'up':
        # Ensure we went up and then down
        return False

    return True


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = mountain_array(array)
    print(result)


if __name__ == "__main__":
    main()
