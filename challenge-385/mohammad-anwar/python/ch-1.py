#!/usr/bin/env python3

import unittest

def uncommon_words(s1: str, s2: str) -> str:
    count = {}
    for word in f"{s1} {s2}".split():
        count[word] = count.get(word, 0) + 1

    return " ".join(sorted([word for word, c in count.items() if c == 1]))


class TestUncommonWords(unittest.TestCase):
    def test_examples(self):
        examples = [
            {"in": ["apple banana apple", "banana orange"], "out": "orange"},
            {"in": ["cat dog", "bird fish"], "out": "bird cat dog fish"},
            {"in": ["the quick brown fox", "the quick"], "out": "brown fox"},
            {"in": ["hello", "hello"], "out": ""},
            {"in": ["blue blue red", "red green green yellow"], "out": "yellow"},
        ]

        for ex in examples:
            with self.subTest(ex=ex):
                self.assertEqual(uncommon_words(*ex["in"]), ex["out"])


if __name__ == "__main__":
    unittest.main()
