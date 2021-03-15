#!/usr/bin/env python3

import unittest
from ch1 import reverse_words

class TestTask1(unittest.TestCase):


    def test_example_cases(self):
        self.assertEqual(
                "Challenge Weekly The", reverse_words("The Weekly Challenge"))
        self.assertEqual(
                "family same the of part are Raku and Perl",
                reverse_words("    Perl and   Raku are  part of the same family  "))


if __name__ == '__main__':
    unittest.main()
