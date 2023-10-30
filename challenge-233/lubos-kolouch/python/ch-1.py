#!/usr/bin/env python
# -*- coding: utf-8 -*-

from collections import Counter
from typing import List


def similar_words(words: List[str]) -> int:
    """
    Calculate the total count of similar words in the given list of words.

    A word is considered similar to another if they have the exact same set of characters.

    Parameters:
    - words (List[str]): A list of words to be checked.

    Returns:
    - int: The total count of similar words.
    """

    # Convert words into a set of unique characters
    unique_sets = [frozenset(word) for word in words]

    # Count occurrences of each unique set
    set_counts = Counter(unique_sets)

    # Calculate total count of similar words
    count = sum(v * (v - 1) // 2 for v in set_counts.values())

    return count


# Test the solution
assert similar_words(["aba", "aabb", "abcd", "bac", "aabc"]) == 2
assert similar_words(["aabb", "ab", "ba"]) == 3
assert similar_words(["nba", "cba", "dba"]) == 0
