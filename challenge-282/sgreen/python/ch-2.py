#!/usr/bin/env python3

import sys


def key_changes(s: str) -> int:
    # Convert the string to lower case
    s = s.lower()

    # Start with the first letter
    current_key = s[0]

    # Count the number of times we change keys
    changes = 0

    for letter in s:
        if letter != current_key:
            # We need to change key
            current_key = letter
            changes += 1

    return changes


def main():
    # Convert input into integers
    result = key_changes(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
