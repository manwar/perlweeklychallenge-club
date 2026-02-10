#!/usr/bin/env python3

import sys


def word_sorter(sentence: str) -> str:
    """
    Write a script to order words in the given sentence alphabetically but keeps the words themselves unchanged

    Params:
        sentence(str): The original sentence

    Returns:
        str: The sorted sentence
    """
    return " ".join(sorted(sentence.split(), key=lambda x: x.lower()))


def main():
    result = word_sorter(sys.argv[1])
    print(result)


if __name__ == "__main__":
    main()
