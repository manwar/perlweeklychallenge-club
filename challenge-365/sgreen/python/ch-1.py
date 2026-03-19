#!/usr/bin/env python3

import string
import sys


def aid_sum(input_string: str, k: int) -> int:
    """
    Convert a lowercase string into numbers using alphabet positions,
    concatenate them to form an integer, then compute the sum of its digits
    repeatedly k times

    Params:
        input_string(str): The input string
        k(int): The number of computations to make

    Returns:
        int: The result as an integer.
    """

    # Treat the result as a string for now
    digits = ''
    for letter in input_string:
        # Concatenate the 1-based index of the letter
        try:
            digits += str(string.ascii_lowercase.index(letter)+1)
        except ValueError:
            # Handle the case where we have unexpected input
            raise ValueError(
                f"The character '{letter}' does not appear to be a lower case letter"
            )

    # Repeat this step k times
    for _ in range(k):
        # Calculate the sum of all the digits
        digits = str(sum(int(i) for i in digits))
        if len(digits) == 1:
            break

    # Return the result as an integer
    return int(digits)


def main():
    result = aid_sum(sys.argv[1], int(sys.argv[2]))
    print(result)


if __name__ == "__main__":
    main()
