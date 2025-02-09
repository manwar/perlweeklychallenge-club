#!/usr/bin/env python3

import sys


def find_anagrams(words: list) -> list:
    # Sort each word alphabetically, ignoring case
    sorted_words = [''.join(sorted(word.lower())) for word in words]
    anagrams = 0

    for idx in range(1, len(words)):
        if sorted_words[idx-1] == sorted_words[idx]:
            # The word at this position is an anagram of the previous word
            anagrams += 1

    # Return the number of words that aren't an anagram
    return len(words) - anagrams


def main():
    result = find_anagrams(sys.argv[1:])
    print(result)


if __name__ == '__main__':
    main()
