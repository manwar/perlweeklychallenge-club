#!/usr/bin/env python3

import sys


def good_integer(n: int) -> str:
    # Convert the integer to a string
    value = str(n)
    length = len(value)

    for pos in range(length-2):
        if (
            value[pos] == value[pos+1]
            and value[pos] == value[pos+2]
            and (pos == 0 or value[pos] != value[pos-1])
            and (pos + 3 == length or value[pos] != value[pos+3])
        ):
            return value[pos:pos+3]

    return '-1'


def main():
    # Convert input into an integer
    result = good_integer(int(sys.argv[1]))
    print(result)


if __name__ == '__main__':
    main()
