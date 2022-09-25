#!/usr/bin/env python

import sys
import yaml


def main(y):
    array = yaml.safe_load(y)

    solution = []
    for i in range(len(array)):

        # See if we have found this list before
        is_unique = True
        for j in range(i):
            if array[i] == array[j]:
                is_unique = False
                break

        if is_unique:
            # We haven't. Add it to the solutions
            solution.append(array[i])

    print(*solution, sep=', ')


if __name__ == '__main__':
    main(sys.argv[1])
