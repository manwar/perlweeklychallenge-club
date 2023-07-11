#!/usr/bin/env python
# -*- coding: utf-8 -*-


def hex_words(dictionary_path):
    hex_map = {"o": "0", "l": "1", "i": "1", "s": "5", "t": "7"}
    valid_chars = set("abcdef" + "".join(hex_map.values()))
    words = []

    with open(dictionary_path, "r") as f:
        for line in f:
            word = line.strip().lower()
            if 2 <= len(word) <= 8 and set(word).issubset(valid_chars):
                words.append("0x" + "".join(hex_map.get(c, c) for c in word))

    return words


# path to dictionary file
dictionary_path = "../../../data/dictionary.txt"

# get hex words
hex_words = hex_words(dictionary_path)

# print hex words
for word in hex_words:
    print(word)
