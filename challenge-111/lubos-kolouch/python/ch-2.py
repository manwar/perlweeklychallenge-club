#!/usr/bin/env python
# -*- coding: utf-8 -*-

def find_longest_ordered_words(filename):
    with open(filename, 'r') as f:
        words = f.read().splitlines()

    longest_length = 0
    longest_words = []
    for word in words:
        if word.lower() == ''.join(sorted(word.lower())):
            if len(word) > longest_length:
                longest_length = len(word)
                longest_words = [word]
            elif len(word) == longest_length:
                longest_words.append(word)
    return longest_words


longest_ordered_words = find_longest_ordered_words('words.txt')
for word in longest_ordered_words:
    print(word)
