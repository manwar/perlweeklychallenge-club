#!/usr/bin/env python3

# Challenge 005
#
# Challenge #2
# Write a program to find the sequence of characters that has the most anagrams.
#
# create a hash of all words in dictionary where key is sorted list of letters
# therefore two anagrams have the same key

import sys
import re

def read_file(filename):
    with open(filename) as f:
        return f.readlines()

def read_words(lines):
    words = []
    for line in lines:
        word = line.strip()
        if not re.search(r"\W", word):
            words.append(word)
    return words

def get_word_key(word):
    letters = sorted([x for x in word.lower()])
    return "".join(letters)

def print_largest_anagram():
    anagrams = {}
    max_anagrams = 0
    for word in read_words(read_file("words.txt")):
        if len(word) >= 2:
            key = get_word_key(word)
            if key in anagrams:
                anagrams[key] += 1
            else:
                anagrams[key] = 1
            max_anagrams = max(max_anagrams, anagrams[key])
    print(f"Maximum of {max_anagrams} anagrams")
    for key in sorted(anagrams):
        if anagrams[key]==max_anagrams:
            print(key)

print_largest_anagram()
