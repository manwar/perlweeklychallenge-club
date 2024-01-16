#!/usr/bin/env python


def most_frequent_letter_pair(s: str) -> str:
    from collections import Counter

    # Counting frequencies of each pair
    pairs = Counter(s[i : i + 2] for i in range(len(s) - 1))

    # Finding the most frequent pair
    most_frequent = max(
        pairs.items(), key=lambda x: (x[1], -ord(x[0][0]), -ord(x[0][1]))
    )

    return most_frequent[0]


# Tests
assert most_frequent_letter_pair("abcdbca") == "bc"
assert most_frequent_letter_pair("cdeabeabfcdfabgcd") == "ab"
