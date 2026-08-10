#!/usr/bin/env python3

"Simon's solution to task 1 of The Weekly Challenge" ""

from collections import Counter
import sys


def uncommon_word(*sentences: str) -> list:
    """
    Write a script to return list of all uncommon words

    Params:
        *sentences (str): One or more sentences

    Returns:
        list[str]: All the words that appear only once
    """
    word_freq = Counter()
    for sentence in sentences:
        word_freq.update(sentence.split())

    return [word for word in word_freq if word_freq[word] == 1]


def main():
    """Convert command line input into parameters for the function and display result"""
    result = uncommon_word(*sys.argv[1:])
    print("(" + ", ".join(f'"{r}"' for r in result) + ")")


# Call main if run from the command line
if __name__ == "__main__":
    main()
