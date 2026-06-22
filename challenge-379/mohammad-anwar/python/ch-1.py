#!/usr/bin/env python3

import unittest

def reverse_string(string: str) -> str:
    chars = list(string)
    _str  = ''

    for i in range(len(chars) - 1, -1, -1):
        _str += chars[i]

    return _str

class TestReverseString(unittest.TestCase):
    def test_examples(self):
        examples = [
            {"in": "", "out": ""},
            {"in": "reverse the given string", "out": "gnirts nevig eht esrever"},
            {"in": "Perl is Awesome", "out": "emosewA si lreP"},
            {"in": "v1.0.0-Beta!", "out": "!ateB-0.0.1v"},
            {"in": "racecar", "out": "racecar"}
        ]

        for ex in examples:
            with self.subTest(ex=ex):
                self.assertEqual(reverse_string(ex["in"]), ex["out"])

if __name__ == '__main__':
    unittest.main()
