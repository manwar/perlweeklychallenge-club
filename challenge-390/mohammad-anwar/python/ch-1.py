#!/usr/bin/env python3

import re
import unittest

def decode_string(s: str) -> str:
    pattern = re.compile(r"(\d+)\[([^\[\]]*)\]")
    while True:
        s, count = pattern.subn(lambda m: m.group(2) * int(m.group(1)), s)
        if count == 0:
            break
    return s

class TestDecodeString(unittest.TestCase):

    def test_examples(self):
        examples = [
            ("2[3[a]]", "aaaaaa"),
            ("10[a]", "aaaaaaaaaa"),
            ("a2[b]c3[d]e", "abbcddde"),
            ("2[a2[b]c]", "abbcabbc"),
            ("1[a]2[b3[c]]", "abcccbccc"),
        ]

        for input_str, expected in examples:
            with self.subTest(input_str=input_str):
                self.assertEqual(decode_string(input_str), expected)

if __name__ == "__main__":
    unittest.main()
