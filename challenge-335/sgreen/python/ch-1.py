#!/usr/bin/env python3

import sys
from collections import Counter


def common_characters(word_list: list[str]) -> list[str]:
    """Find common characters in all words.

    Args:
        word_list (list[str]): List of words to compare.

    Returns:
        list[str]: List of common characters sorted alphabetically.
    """
    solution = []

    # Turn the words into a frequency dict
    freq_list = [Counter(word) for word in word_list]

    # Find the minimum frequency of each character across all words
    for letter in sorted(freq_list[0]):
        min_freq = min(freq[letter] for freq in freq_list)
        if min_freq > 0:
            # ... and add it to the solution
            solution.extend(letter * min_freq)

    return solution


def main():
    result = common_characters(sys.argv[1:])
    print(result)


if __name__ == '__main__':
    main()
