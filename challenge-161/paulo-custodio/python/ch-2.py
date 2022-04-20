#!/usr/bin/env python3

# Challenge 161
#
# Task 2: Pangrams
# Submitted by: Ryan J Thompson
# A pangram is a sentence or phrase that uses every letter in the English
# alphabet at least once. For example, perhaps the most well known pangram is:
#
# the quick brown fox jumps over the lazy dog
# Using the provided dictionary, so that you don't need to include individual
# copy, generate at least one pangram.
#
# Your pangram does not have to be a syntactically valid English sentence (doing
# so would require far more work, and a dictionary of nouns, verbs, adjectives,
# adverbs, and conjunctions). Also note that repeated letters, and even repeated
# words, are permitted.
#
# BONUS: Constrain or optimize for something interesting (completely up to you),
# such as:
# Shortest possible pangram (difficult)
# Pangram which contains only abecedarian words (see challenge 1)
# Pangram such that each word "solves" exactly one new letter. For example, such
# a pangram might begin with (newly solved letters in bold):
#     a ah hi hid die ice tea ...
#     What is the longest possible anagram generated with this method? (All
# solutions will contain 26 words, so focus on the letter count.)
# Pangrams that have the weirdest (PG-13) Google image search results
# Anything interesting goes!

import sys
import re

# read dictionary
dict = []
with open(sys.argv[1]) as f:
    for line in f.readlines():
        word = line.rstrip()
        if re.match(r"^[a-z]+$", word):
            dict.append(word)

# define set of not yet seen letters
pending = set()
for c in range(ord('a'), ord('z')+1):
    pending.add(chr(c))

def next_word():
    max_word = ""
    max_letters = 0
    for word in dict:
        # get new letters
        letters = set()
        for c in word:
            if c in pending:
                letters.add(c)
        # save max letters
        num_letters = len(letters)
        if num_letters>max_letters:
            max_word, max_letters = word, num_letters
    return max_word

# compose words to match most of pending letters
words = []
while pending:
    word = next_word()
    words.append(word)
    for c in word:
        pending.discard(c)
print(" ".join(words))
