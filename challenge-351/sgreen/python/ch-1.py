#!/usr/bin/env python3

import sys


def special_average(ints: list) -> float:
    # Remove min and maximum values
    min_value = min(ints)
    max_value = max(ints)
    short_list = [n for n in ints if n != min_value and n != max_value]

    # If nothing left, return 0
    if not short_list:
        return 0

    # Return the average of the remaining values
    return sum(short_list)/len(short_list)


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = special_average(array)
    print(result)


if __name__ == '__main__':
    main()
