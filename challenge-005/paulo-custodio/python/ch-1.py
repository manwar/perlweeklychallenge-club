#!/usr/bin/env python3

# Challenge 005
#
# Challenge #1
# Write a program which prints out all anagrams for a given word. For more
# information about Anagram, please check this wikipedia page.
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

def print_anagrams(myword):
    myword_key = get_word_key(myword)
    for word in read_words(read_file("words.txt")):
        if get_word_key(word)==myword_key:
            print(word.lower())

print_anagrams(sys.argv[1])
