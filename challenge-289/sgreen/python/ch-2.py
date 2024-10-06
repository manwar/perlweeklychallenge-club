#!/usr/bin/env python3

import random
import re
import sys


def jumbled_letters(s: str) -> str:
    # Split the string into a list of words
    word_list = re.split('([a-z]+)', s, flags=re.IGNORECASE)
    jumbled_phrase = ''

    for word in word_list:
        if re.search('[a-z]{4,}', word, flags=re.IGNORECASE):
            # If the word has more than 3 letters, jumble the middle characters
            jumbled_phrase += word[0] + \
                ''.join(random.sample(word[1:-1], len(word)-2)) + word[-1]
        else:
            # Otherwise, add the word as is (punctuation falls into this category)
            jumbled_phrase += word

    return jumbled_phrase


def main():
    result = jumbled_letters(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
