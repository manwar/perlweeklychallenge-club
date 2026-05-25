#!/usr/bin/env python3

"Simon's solution to task 1 of The Weekly Challenge"""

from collections import Counter
import sys


def single_common_word(array1: list[str], array2: list[str]) -> int:
    """
    Return the number of strings that appear exactly once in each of the two given arrays. String comparison is case sensitive.

    Params:
        array1 (list[str]): The first list of words
        array2 (list[str]): The second list of words

    Returns:
        int: The number of words that appear in each array once.
    """
    # Compute the frequency of each word in each array
    freq1 = Counter(array1)
    freq2 = Counter(array2)

    # Find the unique words in each freq dict
    unique1 = {word for word in freq1 if freq1[word] == 1}
    unique2 = {word for word in freq2 if freq2[word] == 1}

    # Return the number of items in both sets
    return len(unique1 & unique2)


def main():
    """Convert command line input into parameters for the function and display result"""
    # Convert the first two values into lists separated by spaces.
    array1 = sys.argv[1].split()
    array2 = sys.argv[2].split()
    result = single_common_word(array1, array2)
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
