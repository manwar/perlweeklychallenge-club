#!/usr/bin/env python3

import unittest

def make_it_bigger(s, c):
    options = [
        s[:i] + s[i+1:]
        for i in range(len(s))
        if s[i] == c
    ]

    return max(options) if options else s

class TestMakeItBigger(unittest.TestCase):
    def test_examples(self):
        examples = [
            ("15456",  "5", "1546"),
            ("7332",   "3", "732"),
            ("2231",   "2", "231"),
            ("543251", "5", "54321"),
            ("1921",   "1", "921"),
        ]

        for s, c, expected in examples:
            with self.subTest(s=s, c=c):
                self.assertEqual(make_it_bigger(s, c), expected)

if __name__ == "__main__":
    unittest.main()
