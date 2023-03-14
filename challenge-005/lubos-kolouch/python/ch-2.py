#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
This program finds the sequence of characters that has the most anagrams.

Input: 
A string of any length

Output: 
The sequence of characters that has the most anagrams

"""

import itertools


def find_anagrams(string):
    """
    This function takes a string and returns a list of all its anagrams.

    Parameters:
    string (str): The string to be used

    Returns:
    anagrams (list): A list of all the anagrams of the input string
    """

    all_permutations = list(itertools.permutations(string))
    anagrams = []

    for permutation in all_permutations:
        anagram = "".join(permutation)
        anagrams.append(anagram)

    return anagrams


def most_anagrams(string):
    """
    This function takes a string and returns the sequence of characters that has the most anagrams.

    Parameters:
    string (str): The string to be used

    Returns:
    most_anagrams (str): The sequence of characters that has the most anagrams
    """

    all_anagrams = []

    for i in range(1, len(string) + 1):
        all_anagrams.append(find_anagrams(string[:i]))

    max_length = 0
    most_anagrams = ""

    for anagrams in all_anagrams:
        if len(anagrams) > max_length:
            max_length = len(anagrams)
            most_anagrams = anagrams[0]

    return most_anagrams


# Tests


def test_find_anagrams():
    assert find_anagrams("cat") == ["cat", "cta", "act", "atc", "tca", "tac"]


def test_most_anagrams():
    assert most_anagrams("cat") == "ca"


if __name__ == "__main__":
    string = input("Please enter a string: ")
    print(
        f"The sequence of characters that has the most anagrams is: {most_anagrams(string)}"
    )
