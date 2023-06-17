#!/usr/bin/env python
# -*- coding: utf-8 -*-


def good_strings(words, chars):
    char_counts = {char: chars.count(char) for char in set(chars)}
    total = 0
    for word in words:
        word_counts = {char: word.count(char) for char in set(word)}
        if all(word_counts.get(char, 0) <= char_counts.get(char, 0) for char in word):
            total += len(word)
    return total


words = ["cat", "bt", "hat", "tree"]
chars = "atach"
print(good_strings(words, chars))  # Output: 6

words = ["hello", "world", "challenge"]
chars = "welldonehopper"
print(good_strings(words, chars))  # Output: 10
