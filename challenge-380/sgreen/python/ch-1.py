#!/usr/bin/env python3

"Simon's solution to task 1 of The Weekly Challenge"""

from collections import Counter
import sys


def sum_of_frequencies(input_string: str) -> int:
    """
    Find the vowel and consonant with maximum frequency. Return the sum of
    two frequencies.

    Params:
        input_string (str): The string to compute

    Returns:
        int: The sum of the maximum vowel and consonant frequency
    """
    # Compute the frequency of each letter
    freq = Counter(input_string.lower())

    # Update the max_vowels and max_consonants as required
    max_vowels = 0
    max_consonants = 0
    for letter, count in freq.items():
        if letter in {"a", "e", "i", "o", "u"}:
            if count > max_vowels:
                max_vowels = count
        else:
            if count > max_consonants:
                max_consonants = count

    # Return the sum of these two numbers
    return max_vowels + max_consonants


def main():
    """Convert command line input into parameters for the function and display result"""
    result = sum_of_frequencies(sys.argv[1])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
