#!/usr/bin/env python3

import sys


def pile(remain, minimum):
    found = 0
    for take in range(minimum, remain+1):
        if remain == take:
            # We have a solution
            found += 1
        else:
            # Take this amount from the remaining pennies
            found += pile(remain - take, take)

    return found


def main(n):
    print(pile(n, 1))


if __name__ == '__main__':
    main(int(sys.argv[1]))
