#!/usr/bin/env python3

import sys


def main(n):
    # The format we want (a binary string of a given length)
    fmt = f'0{n}b'

    # Make a list with all possible binary values
    l = [format(x, fmt) for x in range(2**n)]

    # Show the list
    print(*l, sep=', ')


if __name__ == '__main__':
    main(int(sys.argv[1]))
