#!/usr/bin/env python3

import sys


def main(ints):
    # Calculate the frequency of all integers
    freq = {}
    for i in ints:
        freq[i] = freq.get(i, 0) + 1

    # Sort the integers in descending order, and then by the frequency
    sorted_ints = sorted(freq, reverse=True)
    sorted_ints = sorted(sorted_ints, key=lambda i: freq[i])

    # The solution has the frequency of each number
    solution = []
    for f in sorted_ints:
        solution += [str(f)] * freq[f]

    # Display the answer
    print('(' + ','.join(solution) + ')')


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
