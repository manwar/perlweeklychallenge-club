#!/usr/bin/env python3

import sys


def string_store(word: str) -> int:
    """
    Calculates the score of a given word based on the absolute difference
    between ASCII values of consecutive characters.

    Args:
        word (str): The input word.

    Returns:
        int: The score of the word.
    """

    score = 0

    # Convert the string to a list of ASCII values
    ascii_values = [ord(char) for char in word]

    # Calculate the score
    for pos in range(len(ascii_values)-1):
        score += abs(ascii_values[pos] - ascii_values[pos+1])

    return score


def main():
    result = string_store(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
