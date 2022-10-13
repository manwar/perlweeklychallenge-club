#!/usr/bin/env python3
"""Test Task 1"""

import unittest
from util import import_task


class TestTask1(unittest.TestCase):
    """Test Task 1"""

    tmod = import_task(1)

    def test_example_cases(self):
        """Test examples from the description"""

        t1 = self.tmod.zip
        a = [1, 2, 3]
        b = ["a", "b", "c"]

        self.assertEqual(list(t1(a, b)), [1, "a", 2, "b", 3, "c"])
        self.assertEqual(list(t1(b, a)), ["a", 1, "b", 2, "c", 3])


if __name__ == "__main__":
    unittest.main()
