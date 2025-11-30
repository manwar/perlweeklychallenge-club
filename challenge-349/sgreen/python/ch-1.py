#!/usr/bin/env python3

import sys


def power_string(input_string: str) -> int:
    """
    Calculate the length of the longest substring of identical
    consecutive letters.

    Args:
        input_string (str): The input string to evaluate.

    Returns:
        int: The length of the longest substring of identical letters.
    """
    # Initialise variables
    current_letter = ''
    current_length = 0
    max_length = 0

    for letter in input_string:
        if letter == current_letter:
            # Increase the length, and update max_length if needed
            current_length += 1
            if current_length > max_length:
                max_length = current_length
        else:
            # Reset for new letter
            current_letter = letter
            current_length = 1

    return max_length


def main():
    result = power_string(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
