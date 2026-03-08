#!/usr/bin/env python3

import re
import sys

from word2num import word2num


def string_lie_detector(input_string: str) -> bool:
    """
    Parse a self-referential string and determines whether its claims about
    itself are true. The string will make statements about its own composition,
    specifically the number of vowels and consonants it contains.

    Params:
        input_string(str): The string to be parsed

    Args:
        bool: Whether the string is truthful
    """

    # Attempt to parse the input string
    match = re.match(
        r"(\w+) . (\w+) vowels? and (\w+) consonants?", input_string)
    if not match:
        raise ValueError("Input string not in expected format")

    # Count the number of vowels and consonants in the first word
    vowel_count = 0
    const_count = 0
    for c in match.group(1).lower():
        if c in "aeiou":
            vowel_count += 1
        else:
            const_count += 1

    # Convert the words in the string into integers
    expected_vowel = word2num(match.group(2))
    expected_const = word2num(match.group(3))

    # Return if the statement is true
    return vowel_count == expected_vowel and const_count == expected_const


def main():
    result = string_lie_detector(sys.argv[1])
    print(result)


if __name__ == "__main__":
    main()
