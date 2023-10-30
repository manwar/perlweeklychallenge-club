#!/usr/bin/env python3

import sys


def main(words):
    # Calculate the occurrences of sorted unique strings
    freq = {}
    for w in words:
        s = ''.join(sorted(set(w.lower())))
        freq[s] = freq.get(s, 0) + 1

    # Now find out how many pairs of similar words there are for each dict key
    solution = 0
    for v in freq.values():
        if v > 1:
            solution += v * (v-1) // 2

    # Display the answer
    print(solution)


if __name__ == '__main__':
    main(sys.argv[1:])
