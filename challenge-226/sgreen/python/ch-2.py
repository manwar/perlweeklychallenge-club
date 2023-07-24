#!/usr/bin/env python3

import sys


def main(ints):
    # The solution is the number of uniq positive integers
    count = len(set(i for i in ints if i != 0))
    print(count)

if __name__ == '__main__':
    # Convert the input into integers
    ints = [int(i) for i in sys.argv[1:]]
    main(ints)
