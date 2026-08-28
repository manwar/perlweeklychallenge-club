#!/usr/bin/env python3

import unittest

def dyck_words(n, u=0, d=0, path=""):
    if u == n and d == n:
        return [path]

    res = []
    if d < u:
        res.extend(dyck_words(n, u, d + 1, path + "D"))
    if u < n:
        res.extend(dyck_words(n, u + 1, d, path + "U"))
    return res


class TestDyckWords(unittest.TestCase):
    def test_dyck_words(self):
        examples = [
            {"in": 1, "out": ["UD"]},
            {"in": 2, "out": ["UDUD", "UUDD"]},
            {
                "in": 3,
                "out": ["UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD"],
            },
            {"in": 0, "out": [""]},
            {
                "in": 4,
                "out": [
                    "UDUDUDUD",
                    "UDUDUUDD",
                    "UDUUDDUD",
                    "UDUUDUDD",
                    "UDUUUDDD",
                    "UUDDUDUD",
                    "UUDDUUDD",
                    "UUDUDDUD",
                    "UUDUDUDD",
                    "UUDUUDDD",
                    "UUUDDDUD",
                    "UUUDDUDD",
                    "UUUDUDDD",
                    "UUUUDDDD",
                ],
            },
        ]
        for ex in examples:
            self.assertEqual(dyck_words(ex["in"]), ex["out"])


if __name__ == "__main__":
    unittest.main()
