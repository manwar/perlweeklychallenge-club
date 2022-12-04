#!/usr/bin/env python3

import string
import sys


def main(s):
    # Create letter to number mapping
    letter_map = {}
    for k, v in enumerate(string.ascii_lowercase):
        letter_map[v] = k

    occurrences = {}
    for word in s:
        # Calculate the differences between characters, and store this
        #  as a space separated string
        diff = ' '.join([
            str(letter_map[word[i]] - letter_map[word[i-1]])
            for i in range(1, len(word))
        ])

        # Add the word to the occurrences dict
        if diff not in occurrences:
            occurrences[diff] = []
        occurrences[diff].append(word)

    # Find the unique words
    unique_words = [v[0] for v in occurrences.values() if len(v) == 1]

    if len(unique_words) > 1:
        print('More than one unique string!')
    elif len(unique_words) == 0:
        print('No unique strings!')
    else:
        print(unique_words[0])


if __name__ == '__main__':
    main(sys.argv[1:])
