#!/usr/bin/env python3

"""Simon's solution to task 2 of The Weekly Challenge"""

import re
import sys

VOWELS = "aeiou"

def is_alt_vc(substr: str) -> bool:
    """Determine if the string is alternating between a vowel and a consonant"""

    # Start with the type of the fist letter
    vowel_next = substr.lower()[0] in VOWELS

    for letter in substr.lower():
        if vowel_next ^ (letter in VOWELS):
            # The letter is the wrong type
            return False
        # The next letter needs to be the opposite
        vowel_next = not(vowel_next)

    # The word alternates between vowels and consonants
    return True

def alt_vc(words: list[str]) -> list[str]:
    # Check the strings only contains letters
    if not all(re.search('^[a-z]+$', word, flags=re.I) for word in words):
        raise ValueError("Some words contain non-letters")

    # Find the shortest word (the first if there is more than one), and its length
    shortest_word = sorted(words, key=len)[0]
    min_length = len(shortest_word)

    # Try for the longest string first
    result = []
    for length in range(min_length, 0, -1):
        for start in range(min_length-length+1):
            substr = shortest_word[start:start+length]
            # The substr needs to appear in all words and correctly alternates
            #  between vowels and consonants
            if all(substr in word for word in words) and is_alt_vc(substr):
                result.append(substr)

        if result:
            # There are valid solutions of this length, return them alphabetically
            return sorted(result)

    # No substrings found matching the criteria.
    return []


def main():
    """Convert command line input into parameters for the function and display result"""
    result = alt_vc(sys.argv[1:])
    print("(" + ", ".join(f'"{word}"' for word in result) + ")")


# Call main if run from the command line
if __name__ == "__main__":
    main()
