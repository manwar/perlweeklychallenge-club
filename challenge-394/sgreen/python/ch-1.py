#!/usr/bin/env python3

"""Simon's solution to task 1 of The Weekly Challenge"""

import re
import string
import sys

UCL = set(string.ascii_uppercase)
LCL = set(string.ascii_lowercase)

def is_alt_case(s: str, upper_first: bool) -> int|None:
    for pos, letter in enumerate(s):
        next_letters = UCL if (upper_first + pos) % 2 else LCL
        if letter in next_letters:
            # Correct case, move on to the next letter
            continue

        # Find the position of the next letter of the expected case, and return
        # one less than that position
        for i in range(pos+ 1, len(s)):
            if s[i] in next_letters:
                return i-1
        else:
            # This should never be called
            raise RuntimeError("Unexpected situation happened")

    # All the letters are correct
    return None

def swap_letters(s: str, pos: int) -> str:
    """Swap the letters at pos and pos+1 around"""
    return s[:pos] + s[pos+1] + s[pos] + s[pos+2:]

def alt_case(input_string: str) -> int:
    # Check the are string is an even length, only contains letters, and half
    #  of them are upper case
    half_length = len(input_string) // 2
    if len(input_string) % 2:
        raise ValueError("String must have an even number of characters")
    if not re.search("^[a-z]+$", input_string, flags=re.I):
        raise ValueError("The word contain non-letter characters")
    if sum(1 for letter in input_string if letter in UCL) != half_length:
        raise ValueError(
            "Letter must contain the same number of upper and lower case letters"
        )

    move_list = []

    for upper_first in {True, False}:
        s = input_string
        moves = 0
        while (next_swap_pos := is_alt_case(s, upper_first)) is not None:
            s = swap_letters(s, next_swap_pos)
            moves += 1

        move_list.append(moves)
    return min(move_list)


def main():
    """Convert command line input into parameters for the function and display result"""
    result = alt_case(sys.argv[1])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
