#!/usr/bin/env python3

import sys


def circular(words: list) -> bool:
    """Check whether the last character of each word is the first character
    of the following word

    Args:
        words (list): A list of words

    Returns:
        bool: Whether the criteria is satisfied.
    """

    for idx in range(1, len(words)):
        # Check if the first letter of this word is the same as the last
        #  letter of the previous word
        if words[idx][0] != words[idx-1][-1]:
            return False

    return True


def main():
    result = circular(sys.argv[1:])
    print(result)


if __name__ == '__main__':
    main()
