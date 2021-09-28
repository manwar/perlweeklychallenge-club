#!/usr/bin/env python3
"""Test Task 2"""

import unittest
from ch2 import find_pairs


class TestTask2(unittest.TestCase):
    """Test Task 2"""

    def test_example_cases(self):
        """Test Task 2"""
        self.assertEqual(('"(["', '")]"'),
                find_pairs('""[]()', '"I like (parens) and the Apple ][+" they said.'))
        self.assertEqual(("/**/<", "/**/>"),
                find_pairs("**//<>", "/* This is a comment (in some languages) */ <could be a tag>"))


if __name__ == '__main__':
    unittest.main()
