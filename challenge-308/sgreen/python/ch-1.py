#!/usr/bin/env python3

import sys


def count_common(str1: list, str2: list) -> int:
    return len(set(str1) & set(str2))


def main():
    # Split the two strings on spaces
    str1 = sys.argv[1].split(' ')
    str2 = sys.argv[2].split(' ')
    result = count_common(str1, str2)
    print(result)


if __name__ == '__main__':
    main()
