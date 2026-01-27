#!/usr/bin/env python3

import sys


def max_string_value(input_strings: list) -> int:
    return max(int(s) if s.isdigit() else len(s) for s in input_strings)


def main():
    result = max_string_value(sys.argv[1:])
    print(result)


if __name__ == "__main__":
    main()
