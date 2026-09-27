#!/usr/bin/env python3

"""Simon's solution to task 2 of The Weekly Challenge"""

import sys
from itertools import combinations


def word_length_product(words: list[str]) -> int:
    """
    Return the maximum value of the product of lengths of two words where the
    two words do not share common letters.

    Params:
        words (list[str]): A list of words

    Returns:
        int: The product of lengths of two words that share no letters
    """
    return max(
        (
            len(word1) * len(word2)
            for word1, word2 in combinations(words, 2)
            if not any(letter in word2 for letter in word1)
        ),
        default=0,
    )


def main():
    """Convert command line input into parameters for the function and display result"""
    result = word_length_product(sys.argv[1:])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
