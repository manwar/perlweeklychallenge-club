#!/usr/bin/env python3

import argparse
import re
import sys


def sc(match):
    # Turn repeated characters into a number of characters and the character
    m = match.group(0)
    return str(len(m)) + m[0]


def string_compress(s: str) -> str:
    return re.sub(r'(([a-z])\2+)', sc, s)


def usc(match):
    # Convert a number and a chacter to the that number of characters
    m = match.group(0)
    return m[-1] * int(m[:-1])


def string_decompress(s: str) -> str:
    return re.sub(r'(\d+[a-z])', usc, s)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--decompress", help="decompress the input", action='store_true')
    parser.add_argument("str", help="the string to compress/decompress")
    args = parser.parse_args()

    if args.decompress:
        result = string_decompress(args.str)
    else:
        result = string_compress(args.str)
    print(result)


if __name__ == '__main__':
    main()
