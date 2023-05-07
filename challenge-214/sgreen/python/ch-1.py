#!/usr/bin/env python

import sys


def main(array):
    score_to_place = {}
    for i, score in enumerate(sorted(array, reverse=True)):
        if score not in score_to_place:
            score_to_place[score] = i+1

    place_to_word = {1: 'G', 2: 'S', 3: 'B'}
    solution = []
    for i in array:
        place = score_to_place[i]
        solution.append(place_to_word.get(place, place))

    print(*solution, sep=', ')


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
