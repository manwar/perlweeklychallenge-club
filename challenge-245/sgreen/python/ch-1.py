#!/usr/bin/env python3

import sys


def main(words, places):
    # Create a dict where the key is the place, and the value is the word
    rankings = {
        place: word for place, word in zip(places, words)
    }

    # Order the words by their ranking
    solution = [rankings[place] for place in sorted(rankings)]
    print(*solution, sep=', ')


if __name__ == '__main__':
    inputs = sys.argv[1:]

    # We need an even number of inputs
    if len(inputs) % 2 == 1:
        raise ValueError('We require an even number of inputs')

    # Split the input into words and places
    half = len(inputs) // 2
    words = inputs[:half]
    # Convert input into integers
    places = [int(n) for n in inputs[half:]]
    main(words, places)
