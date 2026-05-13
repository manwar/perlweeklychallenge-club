#!/usr/bin/env python3

"Simon's solution to task 2 of The Weekly Challenge"""

import sys


def list_division(input_list: list[int], n: int) -> list[list[int]] | None:
    """
    Divide the given list into given integer equal parts. Return None if the
    integer is more than the size of the list

    Params:
        input_list(list[int]): The given list
        n (int): The number of parts to separate the list into

    Returns:
        list[list[int]]: A list of the 'n' different parts.
    """
    result = []
    pos = 0

    # If the list is too short, return None
    if len(input_list) < n:
        return None

    # Calculate how many items each part has, and how many parts have an extra digit
    item_length, extra_first = divmod(len(input_list), n)

    for i in range(n):
        # Determine how many items this part has, and add them to the result
        this_length = item_length + 1 if i < extra_first else item_length
        result.append(input_list[pos:pos+this_length])
        pos += this_length

    return result


def main():
    """Convert command line input into parameters for the function and display result"""
    # Convert input into integers/ Assume last int is the 'n' value
    array = [int(n) for n in sys.argv[1:]]
    result = list_division(array[:-1], array[-1])
    if result is None:
        print("-1")
    else:
        print("("+", ".join("("+",".join(map(str, r))+")" for r in result)+")")


# Call main if run from the command line
if __name__ == "__main__":
    main()
