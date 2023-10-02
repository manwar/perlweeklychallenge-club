#!/usr/bin/env python3

import sys


def main(n):
    # Calculate left and right lists
    l = len(n)
    left = [sum(n[0:i]) for i in range(l)]
    right = [sum(n[i+1:l]) for i in range(l)]

    # Calculate the absolute difference between the list
    solution = [abs(left[i] - right[i]) for i in range(l)]
    print(*solution, sep=', ')


if __name__ == '__main__':
    # Convert input into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
