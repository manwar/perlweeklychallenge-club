#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List, Tuple


def find_shortest_ladder(word1: str, word2: str, wordlist: List[str]) -> List[str]:
    """
    Find the shortest word ladder between two input words.

    Args:
        word1: The first input word.
        word2: The second input word.
        wordlist: A list of words to search for the word ladder.

    Returns:
        A list of words in the ladder if it exists, otherwise an empty list.
    """
    # Check if input words are valid
    wordlen = len(word1)
    wordset = set(wordlist)
    if word1 not in wordset or word2 not in wordset or len(word2) != wordlen:
        return []

    # Use breadth-first search to find shortest ladder
    queue = [(word1, [word1])]
    visited = set([word1])
    while queue:
        word, path = queue.pop(0)
        for i in range(wordlen):
            for char in "abcdefghijklmnopqrstuvwxyz":
                newword = word[:i] + char + word[i + 1 :]
                if newword == word2:
                    return path + [word2]
                if newword in wordset and newword not in visited:
                    queue.append((newword, path + [newword]))
                    visited.add(newword)

    # If no ladder is found, return empty list
    return []


# Test cases
wordlist = ["cold", "cord", "core", "care", "card", "ward", "warm", "worm"]

# Test case 1: Find the shortest ladder from "cold" to "warm"
ladder = find_shortest_ladder("cold", "warm", wordlist)
assert ladder == ["cold", "cord", "card", "ward", "warm"], "Test case 1 failed"
