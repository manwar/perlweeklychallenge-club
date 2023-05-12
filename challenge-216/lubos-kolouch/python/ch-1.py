#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def matching_words(words: List[str], reg: str) -> List[str]:
    reg = reg.upper()
    letters = set(letter for letter in reg if letter.isalpha())
    matches = []
    for word in words:
        upper_word = word.upper()
        matched = all(letter in upper_word for letter in letters)
        if matched:
            matches.append(word)
    return matches


words = ['job', 'james', 'bjorg']
reg = '007 JB'
matches_list = matching_words(words, reg)
print("(", ", ".join(f"'{match}'" for match in matches_list), ")")
