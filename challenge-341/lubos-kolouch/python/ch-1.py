#!/usr/bin/env python3
"""
Task 1: Broken Keyboard
Given a string and a list of broken keys, returns the count of words that can be typed completely.
"""

import unittest


def broken_keyboard(str_input: str, broken_keys: list[str]) -> int:
    """
    Count words that can be typed with broken keys.

    Args:
        str_input: Input string containing words
        broken_keys: List of broken key characters

    Returns:
        Number of words that can be typed completely
    """
    # Convert broken keys to set for O(1) lookup
    broken_set = set(broken_keys)

    # Split string into words
    words = str_input.split()
    count = 0

    # Check each word
    for word in words:
        can_type = True
        # Check if word contains any broken key
        for char in word.lower():
            if char in broken_set:
                can_type = False
                break
        if can_type:
            count += 1

    return count


# Unit tests


class TestBrokenKeyboard(unittest.TestCase):

    def test_example1(self):
        """Test Example 1: Hello World, d broken"""
        self.assertEqual(broken_keyboard("Hello World", ["d"]), 1)

    def test_example2(self):
        """Test Example 2: apple banana cherry, a,e broken"""
        self.assertEqual(broken_keyboard("apple banana cherry", ["a", "e"]), 0)

    def test_example3(self):
        """Test Example 3: Coding is fun, no broken keys"""
        self.assertEqual(broken_keyboard("Coding is fun", []), 3)

    def test_example4(self):
        """Test Example 4: The Weekly Challenge, a,b broken"""
        self.assertEqual(broken_keyboard("The Weekly Challenge", ["a", "b"]),
                         2)

    def test_example5(self):
        """Test Example 5: Perl and Python, p broken"""
        self.assertEqual(broken_keyboard("Perl and Python", ["p"]), 1)


if __name__ == "__main__":
    unittest.main()
