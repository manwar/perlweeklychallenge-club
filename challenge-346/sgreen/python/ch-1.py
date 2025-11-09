#!/usr/bin/env python3

import re
import sys


def is_balanced(s: str) -> bool:
    """Check if a string of parentheses is balanced.

    Args:
        s (str): A string consisting of '(' and ')'.

    Returns:
        bool: True if the string is balanced, False otherwise.
    """
    count = 0
    for char in s:
        if char == '(':
            count += 1
        elif char == ')':
            if count == 0:
                return False
            count -= 1
    return count == 0

def longest_parenthesis(input_string: str) -> int:
    """Return the length of the longest balanced parentheses substring.

    Args:
        input_string (str): A string consisting of '(' and ')'.

    Returns:
        int: Length of the longest balanced parentheses substring.
    """
    # Check the input string is only parentheses
    if not re.search(r'^[()]+$', input_string):
        raise ValueError("Input string must contain only parentheses")

    for length in range(len(input_string), 1, -1):
        for start in range(len(input_string) - length + 1):
            substring = input_string[start:start + length]
            if is_balanced(substring):
                return length

    return 0

def main():
    result = longest_parenthesis(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
