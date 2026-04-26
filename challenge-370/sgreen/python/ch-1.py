#!/usr/bin/env python3

"Simon's solution to task 1 of The Weekly Challenge"""

from collections import Counter
import re
import sys


def popular_word(paragraph: str, banned: list[str]) -> str:
    """
    Return the most popular word that is not banned. It is guaranteed there is
    at least one word that is not banned and the answer is unique. The words
    in paragraph are case-insensitive and the answer should be in lowercase.

    Params:
        paragraph (str): The paragraph
        banned (list): A list of banned words

    Returns:
        str: The most popular non-banned word
    """

    # Convert the banned list to lower case
    banned_list = list(map(lambda x: x.lower(), banned))

    # Extract all the words not in the banned list
    words = [
        word for word in re.split('[^a-z]+', paragraph.lower())
        if word != '' and word not in banned_list
    ]

    # Count the frequency of each word
    freq = Counter(words)

    # Sort by frequency and return last item (word that appears most)
    sorted_freq = sorted(freq.keys(), key=lambda x: freq[x])
    return sorted_freq[-1]


def main():
    """Convert command line input into parameters for the function and display result"""
    result = popular_word(sys.argv[1], sys.argv[2:])
    print('"' + result + '"')


# Call main if run from the command line
if __name__ == "__main__":
    main()
