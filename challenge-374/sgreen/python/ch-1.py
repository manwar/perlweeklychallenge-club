#!/usr/bin/env python3

"Simon's solution to task 1 of The Weekly Challenge"""

import sys


def count_vowel(input_string: str) -> list[str]:
    """
    Generate all possible vowel substrings in the given string. A vowel
    substring is a substring that only consists of vowels and has all five
    vowels present in it.

    Params:
        input_string(str): The string to be used

    Returns:
        list[str]: A list of all substrings that match the criteria.
    """
    l = len(input_string)
    vowels = ["a", "e", "i", "o", "u"]
    solution = []

    # Generate all possible substrings
    for start in range(l - 4):
        for end in range(start+5, l+1):
            substr = input_string[start:end]
            if (
                # Check the substr containers all vowels
                all(v in substr for v in vowels) and
                # ... and only vowels
                not any(c not in vowels for c in substr)
            ):
                # ... and add it to the solution if it does
                solution.append(substr)

    return solution


def main():
    """Convert command line input into parameters for the function and display result"""
    result = count_vowel(sys.argv[1])
    print("(" + ", ".join(f'"{r}"' for r in result) + ")")


# Call main if run from the command line
if __name__ == "__main__":
    main()
