#!/usr/bin/env python3

import sys


def make_it_bigger(number, digit) -> int:
    # It's easier to treat integers as strings
    number = str(number)
    digit = str(digit)

    # Safety check
    if digit not in number:
        raise ValueError(f"The digit {digit} is not in {number}")
    max_number = 0

    # Loop through each position
    for i in range(len(number)):
        if number[i] != digit:
            # Don't consider removing this digit
            continue

        # Make a new number without this digit, and increase max_number if necessary.
        new_number = int(number[:i] + number[i+1:])
        if new_number > max_number:
            max_number = new_number

    return max_number


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = make_it_bigger(array[0], array[1])
    print(result)


if __name__ == "__main__":
    main()
