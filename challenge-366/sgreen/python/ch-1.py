#!/usr/bin/env python3

import sys


def count_prefixes(array: list, prefix: str) -> int:
    """
    Count the number of words in the given array that are a prefix of the given string

    Params:
        array (list): The list of words
        prefix (str): The prefix we are looking for

    Returns:
        int: The number of words in the list that start with the prefix
    """
    return sum(1 for word in array if prefix[:len(word)] == word)


def main():
    # Retrieve words and use the last as prefix
    array = sys.argv[1:]
    prefix = array.pop()
    result = count_prefixes(array, prefix)
    print(result)


if __name__ == "__main__":
    main()
