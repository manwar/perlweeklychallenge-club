#!/usr/bin/env python3

from itertools import product, zip_longest
import re
import sys


def magic_expression(input_string: str | int, target: int) -> list[str]:
    """Return all expressions formed by inserting +, -, * between digits
    of input_string that evaluate to target.

    Args:
        input_string (str | int): A string or integer consisting of digits.
        target (int): The target integer value.

    Returns:
        list[str]: A list of expressions that evaluate to target.
    """
    # Turn input into a string if it isn't already
    input_string = str(input_string)
    if not re.search(r'^[0-9]+$', input_string):
        raise ValueError("Input string must contain only digits")

    # Possible operators to insert between digits
    operators = ['', '+', '-', '*']

    magic_expressions = []

    for ops in product(operators, repeat=len(input_string)-1):
        expression = ''.join(
            digit + op for digit, op in zip_longest(input_string, ops, fillvalue='')
        )
        if re.search(r'[\+\-\*]0\d', expression):
            # Skip expressions with leading zeros
            continue
        if eval(expression) == target:
            magic_expressions.append(expression)

    return magic_expressions


def main():
    result = magic_expression(sys.argv[1], int(sys.argv[2]))
    if not result:
        print("No expressions found")
    else:
        print('("' + '", "'.join(result) + '")')


if __name__ == '__main__':
    main()
