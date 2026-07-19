#!/usr/bin/env python3

"Simon's solution to task 2 of The Weekly Challenge" ""

from itertools import product
import re
import sys


def replace_question_mark(input_string: str) -> list[str]:
    """Generate all binary arrays for input_string where '?' can be 0 or 1.

    Parameters:
        input_string (str): A string containing '0', '1', and '?'
        characters.

    Returns:
        list[str]: A list of strings, where each string is a binary
        values corresponding to one possible combination of '0' and '1' for
        the '?' characters.
    """
    # Check if input_string is valid
    if not re.match(r"^[01?]+$", input_string):
        raise ValueError("input_string must contain only '0', '1', and '?' characters")

    # Nothing to substitute
    if "?" not in input_string:
        return [input_string]

    # Find positions of '?' characters
    question_positions = [i for i, char in enumerate(input_string) if char == "?"]

    # Generate all combinations of '0' and '1' for the '?' positions
    results = []
    for combination in product("01", repeat=len(question_positions)):
        # Convert string to list to allow replacement
        chars = list(input_string)
        # Replace each '?' with corresponding value from combination
        for pos, value in zip(question_positions, combination):
            chars[pos] = value
        results.append("".join(chars))

    return results


def main():
    """Convert command line input into parameters for the function and display result"""
    result = replace_question_mark(sys.argv[1])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
