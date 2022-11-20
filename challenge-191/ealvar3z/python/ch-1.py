#!/usr/bin/env python3
from functools import reduce
import unittest


class TestSolution(unittest.TestCase):
    cases = [
            [1, 2, 3, 4],
            [1, 2, 0, 5],
            [2, 6, 3, 1],
            [4, 5, 2, 3],
    ]

    def twice_largest(self, lst):
        s = sorted(lst)
        head = reduce(lambda x, y: x+y, s[:-1])
        tail = s[-1]

        if head > tail:
            return -1
        else:
            return 1

    def test_twice_largest(self):
        self.assertEqual(self.twice_largest(self.cases[0]), -1, 'example 1')
        self.assertEqual(self.twice_largest(self.cases[1]),  1, 'example 2')
        self.assertEqual(self.twice_largest(self.cases[2]),  1, 'example 3')
        self.assertEqual(self.twice_largest(self.cases[3]), -1, 'example 4')


if __name__ == "__main__":
    unittest.main(verbosity=True)
