#!/usr/bin/env python3

import re
import sys


def most_frequent_word(p: str, b: str) -> str:
    """Find the most frequent word that isn't banned

    Args:
        p (str): The paragraph
        b (str): The banned word

    Returns:
        str: The most frequent word
    """

    # Calculate the frequency of all the words
    freq = {}
    for word in re.findall(r"\w+(?:'\w+)?", p.lower()):
        freq[word] = freq.get(word, 0) + 1

    # Remove the bad word (if it exists)
    freq.pop(b, None)

    # Find the maximum occurrence of any word, and the word that has this
    max_count = max(freq.values())
    words = [k for k in freq if freq[k] == max_count]
    return words[0]


def main():
    result = most_frequent_word(sys.argv[1], sys.argv[2])
    print(result)


if __name__ == '__main__':
    main()
