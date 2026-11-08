#!/usr/bin/env python3

"""Simon's solution to task 2 of The Weekly Challenge"""

import re
import sys
from collections import defaultdict


def string_difference(words: list[str]) -> str:
    """
    Find the word with a unique difference integer.

    Params:
        words (list[str]): The list of words

    Returns:
        str: The word that matches the criteria
    """
    # Check words are of the same length
    if any(len(word) != len(words[0]) for word in words):
        raise ValueError("Words must be of the same length")

    word_difference = defaultdict(list)
    for word in words:
        # Check words only contain lower case letters
        if not re.search("^[a-z]+$", word):
            raise ValueError(f"The word {word} is not all lower case English letters")

        # Create a tuple of the difference between letters
        t = tuple(ord(word[i]) - ord(word[i - 1]) for i in range(1, len(word)))
        word_difference[t].append(word)

    # Find words with unique differences
    unique_words = [
        word_list[0] for word_list in word_difference.values() if len(word_list) == 1
    ]
    if len(unique_words) == 1:
        return unique_words[0]

    raise ValueError(f"There were {len(unique_words)} words with unique differences")


def main():
    """Convert command line input into parameters for the function and display result"""
    result = string_difference(sys.argv[1:])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
