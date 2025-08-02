#!/usr/bin/env python3

import sys


def bitwise_or(ints: list) -> bool:
    # Count the number of even number integers
    even_count = sum(1 for i in ints if i % 2 == 0)

    # True if there are two or more of them
    return even_count >= 2


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = bitwise_or(array)
    print(result)


if __name__ == '__main__':
    main()
