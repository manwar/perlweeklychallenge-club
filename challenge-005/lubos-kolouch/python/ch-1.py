#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
This program prints all anagrams of a given word.

Input:
word - a string representing the word to find anagrams of

Output:
A list of all anagrams of the given word

"""

import itertools


def get_anagrams(word: str) -> set:
    """
    This function takes a word and finds all anagrams of it

    Input:
    word - a string representing the word to find anagrams of

    Output:
    A list of all anagrams of the given word

    """

    # generate all permutations of the given word
    permutations = itertools.permutations(word)

    # convert the permutations to strings
    anagrams = ["".join(p) for p in permutations]

    # remove duplicates
    anagrams = list(set(anagrams))

    return set(anagrams)


# tests
assert get_anagrams("cat") == {"tca", "tac", "act", "atc", "cta", "cat"}
