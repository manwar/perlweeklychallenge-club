#!/usr/bin/env python

# Challenge 007
#
# Challenge #2
# Word Ladder
# A word ladder is a sequence of words [w0, w1, ..., wn] such that each word wi
# in the sequence is obtained by changing a single character in the word wi-1.
# All words in the ladder must be valid English words.
#
# Given two input words and a file that contains an ordered word list, implement
# a routine (e.g., find_shortest_ladder(word1, word2, wordlist)) that finds the
# shortest ladder between the two input words. For example, for the words cold
# and warm, the routine might return:
#
# ("cold", "cord", "core", "care", "card", "ward", "warm")
# However, there's a shortest ladder: ("cold", "cord", "card", "ward", "warm").
#
# Givens:
# All words in the list have the same length.
#
# All words contain only lowercase alphabetical characters.
#
# There are no duplicates in the word list.
#
# The input words aren't empty and aren't equal but they have the same length
# as any word in the word list.
#
# Requirements:
# The routine must return a list of the words in the ladder if it exists.
# Otherwise, it returns an empty list.
#
# If any of the input words is the wrong length (i.e., its length is different
# to a random from the word list) or isn't in the word list, return an empty list.

from __future__ import print_function
import sys
import re
import collections
from collections import deque

def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

def get_args():
    if len(sys.argv) != 3:
        eprint("Usage: ch-2.py word1 word2")
        sys.exit(1)
    word1, word2 = sys.argv[1:]
    if len(word1) != len(word2):
        eprint("words must have the same length")
        sys.exit(1)
    if word1 == word2:
        eprint("words must be different")
        sys.exit(1)
    for word in word1, word2:
        if not re.match(r"^[a-z]+$", word):
            eprint("words must have lower case letters only")
            sys.exit(1)
    return word1, word2

def read_words(filename, length):
    wordlist = set()
    with open(filename, 'r') as f:
        for line in f.readlines():
            word = line.strip()
            if len(word) == length and re.match(r"^[a-z]+$", word):
                wordlist.add(word)
    return wordlist

def find_shortest_ladder(word1, word2, wordlist):
    queue = deque()
    queue.append((word1, [word1]))      # node, path
    while queue:
        word, path = queue.popleft()
        for next in sorted(next_possible_words(word, wordlist - set(path))):
            if next == word2:           # found solution
                return path + [next]
            else:
                queue.append((next, path + [next]))
    return []

def next_possible_words(word1, wordlist):
    next = set()
    for word in wordlist:
        if word != word1 and word_diff(word, word1) == 1:
            next.add(word)
    return next

def word_diff(word1, word2):
    diff = 0
    list1 = list(word1)
    list2 = list(word2)
    for i in range(0, len(list1)):
        if list1[i] != list2[i]:
            diff = diff+1
    return diff

def print_list(list):
    output = "(";
    for word in list:
        output += '"' + word + '", '
    output = output[:-2] + ")"
    print(output)

word1, word2 = get_args()
wordlist = read_words("words.txt", len(word1))
print_list(find_shortest_ladder(word1, word2, wordlist))
