#!/usr/bin/env python3

import unittest

def character_replacement(str_val, k):
    s = list(str_val)
    c = {}
    l = 0
    max_f = 0

    for r in range(len(s)):
        char = s[r]
        c[char] = c.get(char, 0) + 1
        if c[char] > max_f:
            max_f = c[char]
        if (r - l + 1) - max_f > k:
            c[s[l]] -= 1
            l += 1
    return len(s) - l

class TestCharacterReplacement(unittest.TestCase):
    def test_examples(self):
        examples = [
            ("AAAAA", 2, 5),
            ("ABCDE", 4, 5),
            ("AAABBBBAA", 1, 5),
            ("ABACADA", 2, 5),
            ("BAAABAAAA", 1, 8),
        ]

        for s, k, expected in examples:
            with self.subTest(s=s, k=k):
                self.assertEqual(character_replacement(s, k), expected)

if __name__ == '__main__':
    unittest.main()
