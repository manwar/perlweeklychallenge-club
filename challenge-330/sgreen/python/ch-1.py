#!/usr/bin/env python3

import re
import sys


def clear_digits(input_string) -> str:
    """
    Remove all letter/digit pairs from the input string until no more pairs
    can be removed.

    :param input_string: The string from which to remove letter/digit pairs.
    :return: The modified string with all letter/digit pairs removed.
    """
    solution = input_string

    while True:
        # See if there are any letter / digit pairs to remove
        new_string = re.sub(r'[a-z][0-9]', '', solution)
        if new_string == solution:
            # No more pairs to remove, rerturn the result
            return solution

        # Update the solution with the new string and run the loop again
        solution = new_string


def main():
    result = clear_digits(sys.argv[1])
    print('"'+result+'"')


if __name__ == '__main__':
    main()
