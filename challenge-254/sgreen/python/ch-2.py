#!/usr/bin/env python3

import sys


def reverse_vowels(s: str) -> str:
    # Convert it to lower case
    s = s.lower()

    # Extract the vowels
    vowel_list = [c for c in s if c in 'aeiou']

    new_string = ''
    for c in s:
        # If the character here is a vowel
        if c in 'aeiou':
            # ... get the last vowel
            new_string += vowel_list.pop()
        else:
            new_string += c

    return new_string.capitalize()


def main():
    s = sys.argv[1]
    print(reverse_vowels(s))


if __name__ == '__main__':
    main()
