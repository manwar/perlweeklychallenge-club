#!/usr/bin/env python3

import sys


def thousand_separator(number: int) -> str:
    """Format number with thousand separators.

    Args:
        number (int): The number to format.

    Returns:
        str: The formatted number as a string with commas.
    """
    return f"{number:,}"


def main():
    result = thousand_separator(int(sys.argv[1]))
    print(result)


if __name__ == "__main__":
    main()
