#!/usr/bin/env python3

import sys


def count_pairs(words: list) -> int:
    """Count the number of pairs of strings where one is reversed

    Args:
        words (list): A list of words

    Returns:
        int: The number of pairs
    """
    count = 0

    while words:
        # Take one word from the list
        word = words.pop()

        # See if the reverse of it is also in the list
        if word[::-1] in words:
            count += 1

    # Return the number of pairs
    return count


def main():
    result = count_pairs(sys.argv[1:])
    print(result)


if __name__ == '__main__':
    main()
