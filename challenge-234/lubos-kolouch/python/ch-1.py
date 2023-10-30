#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def common_characters(words: List[str]) -> List[str]:
    """
    Returns a list of characters that appear in all the given words.
    """
    # Start with the set of characters from the first word
    common_chars = set(words[0])

    # Intersect with other words
    for word in words[1:]:
        common_chars &= set(word)

    return list(common_chars)


# Testing the Python solution
print(common_characters(["java", "javascript", "julia"]))  # Output: ['j', 'a']
print(common_characters(["bella", "label", "roller"]))    # Output: ['e', 'l']
print(common_characters(["cool", "lock", "cook"]))        # Output: ['c', 'o']
