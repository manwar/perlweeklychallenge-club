#!/usr/bin/env python3

"""Simon's solution to task 2 of The Weekly Challenge"""

import sys


def order_characters(input_string: str, k: int) -> str:
    """
    Find lexicographically smallest string by removing one character from 1 to k
    and appending it to the end of string.

    Params:
        input_string (str): The supplied string
        k (int): The number of positions to consider moving to the end

    Returns:
        str: The smallest string
    """
    # Use a set to store all the strings found
    strings_found = set()

    def find_string(word, k):
        """Recursively compute all valid strings"""
        nonlocal strings_found

        # Add the word provided
        strings_found.add(word)
        for i in range(k):
            # Generate a new word by putting the character at position k to the
            #  end and call the function again if we haven't seen the new word.
            new_word = word[:i] + word[i + 1 :] + word[i]
            if new_word not in strings_found:
                find_string(new_word, k)

    # Find all valid strings, and return the first alphabetically
    find_string(input_string, k)
    return sorted(strings_found)[0]


def main():
    """Convert command line input into parameters for the function and display result"""
    result = order_characters(sys.argv[1], int(sys.argv[2]))
    print('"' + result + '"')


# Call main if run from the command line
if __name__ == "__main__":
    main()
