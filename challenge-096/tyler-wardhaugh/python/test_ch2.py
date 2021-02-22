#!/usr/bin/env python3

import unittest
from ch2 import edit_distance

class TestTask2(unittest.TestCase):


    def test_example_cases(self):
        self.assertEqual(3, edit_distance("kitten", "sitting"))
        self.assertEqual(2, edit_distance("sunday", "monday"))


if __name__ == '__main__':
    unittest.main()
