#!/usr/bin/env python3

import unittest

def base_to_int(num: str, base: int) -> int:
    # Mimics Perl's state variable initialization
    if not hasattr(base_to_int, "chars"):
        charset = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/"
        base_to_int.chars = {char: i for i, char in enumerate(charset)}

    val = 0
    for char in num:
        val = val * base + base_to_int.chars[char]
    return val

class TestBaseToInt(unittest.TestCase):

    def test_examples(self):
        examples = [
            {"in": ["101010",  2], "out": 42       },
            {"in": ["EEADEE", 16], "out": 15642094 },
            {"in": ["755",     8], "out": 493      },
            {"in": ["1BRJB",  36], "out": 2228519  },
            {"in": ["7MyqL",  64], "out": 123456789},
        ]

        for ex in examples:
            with self.subTest(ex=ex):
                self.assertEqual(base_to_int(*ex["in"]), ex["out"])


if __name__ == "__main__":
    unittest.main()
