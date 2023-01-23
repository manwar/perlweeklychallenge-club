#!/usr/bin/env python3

import sys


def main(n):
    solutions = []

    for start in range(len(n)-2):
        # Calculate the difference between the first two values
        diff = abs(n[start] - n[start+1])

        for end in range(start+2, len(n)):
            if abs(n[end] - n[end-1]) == diff:
                # We have a solution
                solutions.append(tuple(n[start:end+1]))
            else:
                break

    if solutions:
        print(*solutions, sep=', ')
    else:
        print('()')


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
