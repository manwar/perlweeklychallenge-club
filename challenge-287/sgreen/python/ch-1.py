#!/usr/bin/env python3

import re
import sys


def strong_password(password: str) -> int:
    """The minimum number of steps required to make the given string very strong password.

    Args:
        password (str): The supplied password.

    Returns:
        int: The minimum number of steps required.
    """

    # Count consecutive characters
    cons_count = 0
    for c in re.findall(r'((.)\2{2,})', password):
        # For every 3 consecutive characters, we need to replace one
        cons_count += len(c[0]) // 3

    # Additional characters require to make it at least 6 characters
    char_count = max(0, 6 - len(password))

    # Count the number of missing character types
    type_count = 0
    if not re.search(r'[a-z]', password):
        type_count += 1
    if not re.search(r'[A-Z]', password):
        type_count += 1
    if not re.search(r'[0-9]', password):
        type_count += 1

    # Since the type change can be covered by one of the other required
    #  changes, return the maximum of the two
    return max(cons_count + char_count, type_count)


def main():
    result = strong_password(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
