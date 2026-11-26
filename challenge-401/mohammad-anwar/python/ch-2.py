#!/usr/bin/env python3

from collections import Counter
import unittest

def extract_digits(s: str) -> str:
    c = Counter(s)

    n = {
        0: c["z"],
        2: c["w"],
        4: c["u"],
        6: c["x"],
        8: c["g"],
    }
    n[1] = c["o"] - n[0] - n[2] - n[4]
    n[3] = c["h"] - n[8]
    n[5] = c["f"] - n[4]
    n[7] = c["s"] - n[6]
    n[9] = c["i"] - n[5] - n[6] - n[8]

    return "".join(str(d) * n[d] for d in range(10))

class TestExtractDigits(unittest.TestCase):
    def test_examples(self):
        examples = [
            ("zroezerotwotwotwo", "00222"),
            ("sveeeinght", "78"),
            ("onenineninefive", "1599"),
            ("zeroonetwothreeeightfivesixsevenninefour", "0123456789"),
            ("ninenineninenine", "9999"),
        ]
        for inp, out in examples:
            with self.subTest(inp=inp):
                self.assertEqual(extract_digits(inp), out)

if __name__ == "__main__":
    unittest.main()
