#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def word_sequence(S: str, W: List[str]) -> List[str]:

    def helper(s: str, words: List[str]) -> List[str]:
        if not s:
            return words
        for word in W:
            if s.startswith(word):
                result = helper(s[len(word):], words + [word])
                if result:
                    return result
        return []

    result = helper(S, [])
    return result if result else [0]


S1 = "perlweeklychallenge"
W1 = ["weekly", "challenge", "perl"]

S2 = "perlandraku"
W2 = ["python", "ruby", "haskell"]

print(word_sequence(S1, W1))  # Output: ['perl', 'weekly', 'challenge']
print(word_sequence(S2, W2))  # Output: [0]
