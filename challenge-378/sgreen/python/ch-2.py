#!/usr/bin/env python3

"Simon's solution to task 2 of The Weekly Challenge"""

import re
import sys


def word_to_number(word: str) -> int:
    """
    Convert a word into an integer

    Params:
        word(str): The word to convert

    Returns:
        int: The number that this represents
    """

    # Check the word only contains the letters 'a' to 'j'
    if not re.search('^[a-j]+$', word):
        raise ValueError(f"String '{word}' contains invalid characters")

    # Convert into an integer
    number_string = "".join(str(ord(c) - ord('a')) for c in word)
    return int(number_string)


def sum_of_words(str1, str2, str3) -> bool:
    """
    Find if sum of first two strings return the third string where 'a'
    represents zero to 'j' is nine.

    Params:
        str1 (str): The first word to add
        str2 (str): The second word to add
        str3 (str): The expected sum

    Returns:
        boo: If the word equation is correct
    """

    return word_to_number(str1) + word_to_number(str2) == word_to_number(str3)


def main():
    """Convert command line input into parameters for the function and display result"""
    # Convert input into integers
    result = sum_of_words(*sys.argv[1:])
    print("true" if result else "false")


# Call main if run from the command line
if __name__ == "__main__":
    main()
