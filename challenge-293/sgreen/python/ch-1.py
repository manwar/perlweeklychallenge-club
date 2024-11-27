#!/usr/bin/env python3

import sys


def similar_dominoes(dominoes: list) -> int:
    count = 0

    for i in range(len(dominoes)):
        for j in range(len(dominoes)):
            if i == j:
                # Don't compare the same domino!
                continue
            if (dominoes[i][0] == dominoes[j][0] and dominoes[i][1] == dominoes[j][1]) \
                    or (dominoes[i][0] == dominoes[j][1] and dominoes[i][1] == dominoes[j][0]):
                # There is a match
                count += 1
                break

    # Return the number of matching dominoes
    return count


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    dominoes = [[array[i], array[i + 1]] for i in range(0, len(array), 2)]
    result = similar_dominoes(dominoes)
    print(result)


if __name__ == '__main__':
    main()
