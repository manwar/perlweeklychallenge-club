#!/usr/bin/env python3

import unittest
from ch1 import readN

class TestTask1(unittest.TestCase):
    input_filename = '../clojure/resources/input.txt'

    def test_example_cases(self):
        self.assertEqual("1234", readN(self.input_filename, 4))
        self.assertEqual("5678", readN(self.input_filename, 4))
        self.assertEqual("90", readN(self.input_filename, 4))


if __name__ == '__main__':
    unittest.main()
