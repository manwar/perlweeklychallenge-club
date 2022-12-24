#!/usr/bin/python

import sys


def is_simple_number(n):
    # Determine if the number is simple
    seen = {}
    for i in str(n):
        if i in seen:
            # We've seen the digit before. It's not simple
            return False
        seen[i] = 1

    # It is simple
    return True


def main(n):
    # Iterate through the list counting the number of simple numbers
    simple_count = 0
    for i in range(1, n+1):
        if is_simple_number(i):
            simple_count += 1

    # Print the result
    print(simple_count)


if __name__ == '__main__':
    main(int(sys.argv[1]))
