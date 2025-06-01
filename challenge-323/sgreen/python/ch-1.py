#!/usr/bin/env python3

import sys


def increment_decrement(operations: list) -> int:
    """
    This function takes a list of strings representing increment and decrement operations
    on a variable `x` initialized to 0. It returns the final value of `x` after applying
    all operations in the list.
    :param operations: List of strings, each representing an operation on `x`
    :return: Final value of `x` after all operations
    """

    counter = 0
    for operation in operations:
        if operation == "x++" or operation == "++x":
            counter += 1
        elif operation == "x--" or operation == "--x":
            counter -= 1
        else:
            raise ValueError(f"Unknown operation: {operation}")

    return counter


def main():
    result = increment_decrement(sys.argv[1:])
    print(result)


if __name__ == '__main__':
    main()
