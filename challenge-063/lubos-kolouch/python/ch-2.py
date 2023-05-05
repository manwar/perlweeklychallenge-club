#!/usr/bin/env python
# -*- coding: utf-8 -*-


def min_rotations(word: str) -> int:
    original_word = word
    rotation_count = 1

    while True:
        rotation = rotation_count % len(word)
        word = word[rotation:] + word[:rotation]
        if word == original_word:
            break
        rotation_count += 1

    return rotation_count


word = 'xyxx'
print(f"Minimum non-zero rotations for '{word}': {min_rotations(word)}"
      )  # Output: 7
