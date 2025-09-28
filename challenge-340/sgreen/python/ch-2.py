#!/usr/bin/env python3

import re
import sys


def ascending_numbers(input_string: str) -> bool:
    """
    Check if numbers in the input string are in ascending order.

    Args:
        input_string (str): The input string containing numbers.

    Returns:
        bool: True if numbers are in ascending order, False otherwise.
    """

    # Extract numbers from the input string
    number_list = [int(n) for n in input_string.split() if re.match(r'^\d+$', n)]

    if not number_list:
        raise ValueError("No numbers found in the input string.")

    # Check for ascending sequence
    for i in range(1, len(number_list)):
        if number_list[i-1] >= number_list[i]:
            return False

    return True


def main():
    result = ascending_numbers(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
