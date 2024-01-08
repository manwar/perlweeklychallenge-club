#!/usr/bin/env python3

import sys


def main(ints):
    freq = {}
    for i in ints:
        freq[i] = freq.get(i, 0) + 1

    if any(True for f in freq if freq[f] % 2 == 1):
        print('()')
        return

    solution = []
    for i in freq:
        for _ in range(freq[i]//2):
            solution.append(f'({i}, {i})')

    print(*solution, sep=', ')


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
