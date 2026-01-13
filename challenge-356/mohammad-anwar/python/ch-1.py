#!/usr/bin/env python3

import unittest

def count_one(n):
    k = [1, 2, 2]
    i = 2

    while len(k) < n:
        val = k[-1] ^ 3
        count = k[i]
        i += 1
        k.extend([val] * count)

    s = "".join(map(str, k[0:n]))
    return s.count("1")

class TestKolakoski(unittest.TestCase):
    def test_examples(self):
        examples = [
            {"in": 4, "out": 2},
            {"in": 5, "out": 3},
            {"in": 6, "out": 3},
            {"in": 7, "out": 4},
            {"in": 8, "out": 4},
        ]
        for ex in examples:
            self.assertEqual(count_one(ex["in"]), ex["out"])

if __name__ == "__main__":
    unittest.main()
