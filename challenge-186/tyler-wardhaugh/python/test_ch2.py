#!/usr/bin/env python3
"""Test Task 2"""

import unittest
from util import import_task


class TestTask2(unittest.TestCase):
    """Test Task 2"""

    tmod = import_task(2)

    def test_example_cases(self):
        """Test examples from the description"""

        t2 = self.tmod.makeover

        self.assertEqual(t2("ÃÊÍÒÙ"), "AEIOU")
        self.assertEqual(t2("âÊíÒÙ"), "aEiOU")


if __name__ == "__main__":
    unittest.main()
