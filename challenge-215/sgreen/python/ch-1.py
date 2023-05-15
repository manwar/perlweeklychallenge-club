#!/usr/bin/env python3

import sys


def main(words):
    current_word = words.pop(0)
    unsorted_words = 0

    if any(word < current_word for word in words):
        # If the first word is not the smallest, the whole list is unsorted
        print(len(words)+1)
        return

    for word in words:
        if word >= current_word:
            # The next word is in order
            current_word = word
        else:
            # The word is less than the current word
            unsorted_words += 1

    print(unsorted_words)


if __name__ == '__main__':
    main(sys.argv[1:])
