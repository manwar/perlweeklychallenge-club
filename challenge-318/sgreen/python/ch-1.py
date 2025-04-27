#!/usr/bin/env python3

import re
import sys


def group_position(letters: str) -> list[str]:
    # Find all occurrences of a character repeated three or more times
    # Each matches is a tuple of the entire match, and the single character
    matches = re.findall(r"((.)\2{2,})", letters)

    # We only want the entire matches
    return [m[0] for m in matches]


def main():
    result = group_position(sys.argv[1])

    # Print the output in the expected format
    print('"' + '", "'.join(result) + '"')


if __name__ == '__main__':
    main()
