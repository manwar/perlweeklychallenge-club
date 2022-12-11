#!/usr/bin/env python3

import sys


def main(s):
    # Calculate the frequency of each letter
    letter_freq = {}
    for letter in s:
        letter_freq[letter] = letter_freq.get(letter, 0) + 1

    # Calculate the frequency of frequencies :)
    freq = {}
    for i in letter_freq.values():
        freq[i] = freq.get(i, 0) + 1

    solution = 0
    # A solution is only possible if there are two different frequencies ...
    if len(freq) == 2:
        min_freq = min(freq.keys())
        max_freq = max(freq.keys())

        # ... and the minimum frequency only occurs once,
        if min_freq == 1 and freq[1] == 1:
            solution = 1

        # ... or the difference between them is 1, and the higher frequency
        #  only occurs once.
        elif min_freq == max_freq - 1 and freq[max_freq] == 1:
            solution = 1
    elif len(freq) == 1 and 1 in freq:
        # ... or the only thing we have is single letters
        solution = 1

    print(solution)


if __name__ == '__main__':
    main(sys.argv[1])
