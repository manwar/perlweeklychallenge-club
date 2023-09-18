#!/usr/bin/env python3

import sys


def main(words):
    # Turn each word into a set
    sets = [set(w) for w in words]
    first_set = sets.pop(0)

    # The solution is the intersection of all sets
    solution = first_set.intersection(*sets)
    print(*sorted(solution), sep=', ')


if __name__ == '__main__':
    main(sys.argv[1:])
