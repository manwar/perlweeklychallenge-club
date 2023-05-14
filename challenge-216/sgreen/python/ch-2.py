#!/usr/bin/env python3

import itertools
import math
import sys


def get_frequency(word):
    freq = {}
    for letter in word:
        if 'a' <= letter <= 'z':
            freq[letter] = freq.get(letter, 0) + 1

    return freq


def main(words):
    # The last value is the word we are matching
    target_word = words.pop()
    target_freq = get_frequency(target_word)

    # Lets check that a solution is possible
    combined = ''.join(words)
    for letter in target_freq:
        if letter not in combined:
            # The letter doesn't exist in the words, so no solution is possible
            print(0)
            return

    # What is the highest frequency
    highest = max(target_freq.values())
    word_count = len(words)
    min_stickers = math.inf

    for freq in itertools.product(range(highest+1), repeat=word_count):
        if sum(freq) >= min_stickers:
            # This solution won't be better, so skip it
            continue

        # Combine all the words with the defined frequency
        sticker_letters = ''.join([words[x] * freq[x]
                                  for x in range(word_count)])
        sticker_freq = get_frequency(sticker_letters)

        for letter in target_freq:
            if letter not in sticker_freq or sticker_freq[letter] < target_freq[letter]:
                # Either a letter is missing, or doesn't occur enough times
                break
        else:
            # We have a new solution with fewer letters
            min_stickers = sum(freq)

    print(min_stickers)


if __name__ == '__main__':
    main(sys.argv[1:])
