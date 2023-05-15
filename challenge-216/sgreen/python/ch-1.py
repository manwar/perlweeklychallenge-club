#!/usr/bin/env python3

import sys


def get_frequency(word):
    '''Return a dict with the frequency of each letter'''
    freq = {}
    for letter in word.upper():
        if 'A' <= letter <= 'Z':
            freq[letter] = freq.get(letter, 0) + 1

    return freq


def main(words):
    # The last value is the plate we are matching
    plate = words.pop()
    plate_freq = get_frequency(plate)
    solution = []

    for word in words:
        # Calculate the frequency of letters in the current word
        word_freq = get_frequency(word)
        for letter, cnt in plate_freq.items():
            # Check that letters in the plate appear in the word
            if letter not in word_freq or cnt > word_freq[letter]:
                break
        else:
            solution.append(word)

    print(*solution, sep=', ')


if __name__ == '__main__':
    main(sys.argv[1:])
