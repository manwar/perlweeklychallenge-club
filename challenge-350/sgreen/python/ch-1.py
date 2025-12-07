#!/usr/bin/env python3

import sys


def good_substr(input_string: str) -> int:
    """
    Count the number of "good" substrings of length 3 in the input string.

    Args:
        input_string (str): The input string to check.

    Returns:
        int: The count of good substrings.
    """
    count = 0

    for i in range(len(input_string) - 2):
        # Retrieve the three character substring from position i
        substr = input_string[i:i + 3]

        # If they are all different, increment the count
        if len(set(substr)) == 3:
            count += 1

    return count


def main():
    result = good_substr(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
