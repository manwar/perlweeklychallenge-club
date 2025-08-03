#!/usr/bin/env python3

import sys


def binary_date(input_string: str) -> str:
    """Convert a date string in the format 'YYYY-MM-DD' to a binary representation.

    Args:
        input_string (str): The date string in 'YYYY-MM-DD' format.

    Returns:
        str: The binary representation of the date, with parts separated by hyphens.
    """

    # Split the input string by hyphens
    date_parts = input_string.split('-')

    # Convert each part to binary and remove the '0b' prefix
    binary_parts = [bin(int(part))[2:] for part in date_parts]

    # Join the binary parts with hyphens
    return '-'.join(binary_parts)


def main():
    result = binary_date(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
