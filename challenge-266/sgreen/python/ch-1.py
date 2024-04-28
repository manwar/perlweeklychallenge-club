#!/usr/bin/env python3

from collections import defaultdict
import sys


def uncommon_words(*strings) -> list:
    """Find words that only occur once in one string, and don't appear in others

    Params:
        strings: One or more strings

    Returns:
        list: Words that meat the criteria
    """
    freq = defaultdict(int)

    # Compute the frequency of each word
    for string in strings:
        for word in string.split(' '):
            freq[word] += 1

    # Return the word(s) that appear only once
    return [w for w in freq if freq[w] == 1]


def main():
    result = uncommon_words(*sys.argv[1:])

    if len(result) == 0:
        # If there is no result, show an empty string
        print("('')")
    else:
        print("('" + "', '".join(result) + "')")


if __name__ == '__main__':
    main()
