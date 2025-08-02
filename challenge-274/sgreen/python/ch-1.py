#!/usr/bin/env python3

import sys


def goat_latin(sentence: str) -> str:
    # Split on each word
    words = sentence.split(' ')
    for i, word in enumerate(words):
        # If the first letter is not a vowel, move it to the end
        if word[0].lower() not in ['a', 'e', 'i', 'o', 'u']:
            word = word[1:] + word[0]

        # Add the appropriate suffix
        words[i] = word + 'maa' + 'a' * i

    return ' '.join(words)


def main():
    result = goat_latin(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
