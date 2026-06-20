#!/usr/bin/env python3

import re
import unittest

examples = [
    { "in": ["acb", "cba", "cdb" ],   "out": "true"  },
    { "in": ["aab", "aac", "ad"  ],   "out": "true"  },
    { "in": ["bc",  "je",  "jg"  ],   "out": "false" },
    { "in": ["a",   "aaaa", "aa" ],   "out": "true"  },
    { "in": ["c",   "d",    "h"  ],   "out": "false" },
]

def sum_of_words(*words):
    nums = list(map(lambda s: int(re.sub(r'.', lambda m: str(ord(m.group(0)) - 97), s)), words))
    return "true" if nums[0] + nums[1] == nums[2] else "false"

class TestSumOfWords(unittest.TestCase):
    def test_examples(self):
        for ex in examples:
            self.assertEqual(sum_of_words(*ex["in"]), ex["out"])

if __name__ == "__main__":
    unittest.main()
