#!/usr/bin/env python3

import re
import unittest

examples = {
    "10#11#12":  "jkab",
    "1326#":     "acz",
    "25#24#123": "yxabc",
    "20#5":      "te",
    "1910#26#":  "aijz",
}

def decrypt_string(s: str) -> str:
    return re.sub(r'(\d{2})#|(\d)', lambda m: chr(int(m.group(1) or m.group(2)) + 96), s)

class TestDecryptString(unittest.TestCase):
    def test_examples(self):
        for input, expected in examples.items():
            with self.subTest(input=input):
                self.assertEqual(decrypt_string(input), expected)

unittest.main()

