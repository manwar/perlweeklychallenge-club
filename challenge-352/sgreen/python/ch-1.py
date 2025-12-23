#!/usr/bin/env python3

import sys


def match_string(words: list) -> list:
    # List of matching words
    matches = []

    # Loop over each word
    for i, word in enumerate(words):
        # Skip if the word is already matched
        if word in matches:
            continue

        # Check if the word is a substring of any other word
        if any(word in other_word for j, other_word in enumerate(words) if i != j):
            matches.append(word)

    # Return the list of matching words
    return matches


def main():
    result = match_string(sys.argv[1:])
    print(result)


if __name__ == '__main__':
    main()
