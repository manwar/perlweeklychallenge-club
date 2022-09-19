#!/usr/bin/env python

import sys


def get_value(l, quart):
    # Calculate the position of the value we require
    pos = (len(l)-1) * quart / 100
    i = int(pos)

    if i == pos:
        # It is a single value
        return l[i]

    # We need the average of two numbers
    val = (l[i] + l[i+1]) / 2
    return int(val) if int(val) == val else val


def main(l):

    # Sort the list
    l = sorted([int(x) for x in l])
    solution = []

    # Calculate the five values
    for quart in range(0, 101, 25):
        solution.append(get_value(l, quart))

    print(*solution, sep=', ')


if __name__ == '__main__':
    main(sys.argv[1:])
