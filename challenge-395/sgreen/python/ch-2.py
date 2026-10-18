#!/usr/bin/env python3

"""Simon's solution to task 2 of The Weekly Challenge"""

import sys

# def find_word(word_s)


def find_word_squares(
    words: list[str], words_so_far: list[str] | None = None
) -> list[str] | None:
    """
    A recursive function to find the correct words square

    Params:
        words (list[str]): A list of possible words
        words_so_far (list[str]|None): The words so far, or None for the first call

    Returns:
        list[str]|None: The words that make up a word square or None if there is none.
    """
    if words_so_far is None:
        # First call
        words_so_far = []

    length = len(words[0])
    if len(words_so_far) == length:
        # We have found a valid list, return upstream
        return words_so_far

    # Calculate the position we need to find next, and the letters it starts with
    this_pos = len(words_so_far)
    starts_with = "".join(word[this_pos] for word in words_so_far)
    possible_next_words = [
        word
        for word in words
        if word not in words_so_far and word.startswith(starts_with)
    ]

    # Loop through possible next words, calling the function again
    for word in possible_next_words:
        result = find_word_squares(words, words_so_far + [word])
        if result:
            # We have found a valid list, return upstream
            return result

    # No combination is found.
    return None


def word_squares(words: list[str]) -> list[str] | None:
    # Check all words are the same length
    if any(len(word) != len(words[0]) for word in words):
        raise ValueError("All words must be the same length")

    # Call a recursive function to find the correct word order
    return find_word_squares(words)


def main():
    """Convert command line input into parameters for the function and display result"""
    result = word_squares(sys.argv[1:])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
