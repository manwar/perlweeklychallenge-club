#!/usr/bin/env python3

import sys
from itertools import zip_longest


def merge_strings(words: list) -> str:
    """Merge strings together by taking the first character from each word,
      then the second, and so on.

    Args:
        words (list): A list of words

    Returns:
        str: The merged string
    """
    return ''.join(''.join(s) for s in zip_longest(*words, fillvalue=''))


def main():
    result = merge_strings(sys.argv[1:])
    print(result)


if __name__ == '__main__':
    main()
