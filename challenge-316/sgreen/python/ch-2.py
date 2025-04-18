#!/usr/bin/env python3

import re
import sys


def subsequence(str1: str, str2: str) -> bool:
    """Determine if the first string is a subsequence of the second string

    Args:
        str1 (str): The first string
        str2 (str): The second string

    Returns:
        bool: Whether the first string is a subsequence of the second string
    """

    r = '.*'.join(map(re.escape, (l for l in str1)))
    return bool(re.search(r, str2))


def main():
    result = subsequence(sys.argv[1], sys.argv[2])
    print(result)


if __name__ == '__main__':
    main()
