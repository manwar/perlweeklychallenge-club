#!/usr/bin/env python3

import sys


def closest_palindrome(i: int) -> int:
    # Negative integers always have a closest palindrome of 0
    if i < 0:
        return 0

    offset = 1
    while True:
        check = i - offset
        if str(check) == str(check)[::-1]:
            return check

        check = i + offset
        if str(check) == str(check)[::-1]:
            return check

        offset += 1


def main():
    # Convert input into integers
    result = closest_palindrome(int(sys.argv[1]))
    print(result)


if __name__ == '__main__':
    main()
