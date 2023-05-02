#!/usr/bin/env python
# -*- coding: utf-8 -*-


def count_unsorted_words(words):
    count = 0

    for word in words:
        count += is_unsorted(word)

    return count


def is_unsorted(word):
    previous_char = word[0]

    for i in range(1, len(word)):
        current_char = word[i]
        if current_char < previous_char:
            return 1
        previous_char = current_char

    return 0


# Test cases
words1 = ["abc", "xyz", "tsu"]
words2 = ["rat", "cab", "dad"]
words3 = ["x", "y", "z"]

print(count_unsorted_words(words1))  # Output: 1
print(count_unsorted_words(words2))  # Output: 3
print(count_unsorted_words(words3))  # Output: 0
