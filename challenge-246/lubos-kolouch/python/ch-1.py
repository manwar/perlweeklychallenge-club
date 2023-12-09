#!/usr/bin/env python

import random
from typing import List


def pick_lotto_numbers() -> list[int]:
    return random.sample(range(1, 50), 6)


# Test
import unittest


class TestLottoNumbers(unittest.TestCase):
    def test_lotto_numbers(self):
        result = pick_lotto_numbers()
        self.assertEqual(len(result), 6)
        self.assertEqual(len(set(result)), 6)
        for num in result:
            self.assertTrue(1 <= num <= 49)


if __name__ == "__main__":
    unittest.main()

# Main
for num in sorted(pick_lotto_numbers()):
    print(num)
