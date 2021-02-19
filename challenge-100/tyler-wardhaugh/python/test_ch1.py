#!/usr/bin/env python3

import unittest
from ch1 import fun_time

class TestTask1(unittest.TestCase):


    def test_example_cases(self):
        self.assertEqual('17:15', fun_time('05:15 pm'))
        self.assertEqual('17:15', fun_time('05:15pm'))
        self.assertEqual('07:15PM', fun_time('19:15'))


if __name__ == '__main__':
    unittest.main()
