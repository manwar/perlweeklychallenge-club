#!/usr/bin/env python3
"""
Challenge 018, Task 1: Longest common substring

Write a script that takes 2 or more strings as command line parameters
and print the longest common substring.

For example, the longest common substring of "ABABC", "BABCA", "ABCBA"
is "ABC" of length 3.

Author: Lubos Kolouch
"""

import unittest


def longest_common_substring(strings: list[str]) -> str:
    """
    Find the longest common substring among a list of strings.

    Uses dynamic programming approach to find the longest common substring.

    Args:
        strings: List of strings to find common substring for

    Returns:
        The longest common substring

    Examples:
        >>> longest_common_substring(["ABABC", "BABCA", "ABCBA"])
        'ABC'
        >>> longest_common_substring(["abc", "def"])
        ''
    """
    if not strings:
        return ""
    if len(strings) == 1:
        return strings[0]

    # Start with the shortest string's substrings
    shortest = min(strings, key=len)
    n = len(shortest)

    # Try each possible substring length from n down to 1
    for length in range(n, 0, -1):
        for start in range(n - length + 1):
            substring = shortest[start : start + length]

            # Check if this substring exists in all other strings
            if all(substring in s for s in strings):
                return substring

    return ""


def longest_common_substring_length(strings: list[str]) -> int:
    """
    Find the length of the longest common substring.

    Args:
        strings: List of strings

    Returns:
        Length of longest common substring
    """
    return len(longest_common_substring(strings))


def get_all_common_substrings(strings: list[str]) -> list[str]:
    """
    Get all common substrings sorted by length (descending).

    Args:
        strings: List of strings

    Returns:
        List of common substrings, longest first
    """
    if not strings:
        return []

    shortest = min(strings, key=len)
    n = len(shortest)

    common = set()
    for length in range(1, n + 1):
        for start in range(n - length + 1):
            substring = shortest[start : start + length]
            if all(substring in s for s in strings):
                common.add(substring)

    return sorted(common, key=len, reverse=True)


def main() -> None:
    """Main function to display results."""
    test_cases = [
        ["ABABC", "BABCA", "ABCBA"],
        ["abc", "def", "xyz"],
        ["hello", "world"],
        ["programming", "progress", "program"],
        ["abc", "abc"],
    ]

    for strings in test_cases:
        result = longest_common_substring(strings)
        print(f"Strings: {strings}")
        print(f"Longest common substring: '{result}' (length: {len(result)})")
        print()


if __name__ == "__main__":
    main()


class TestLongestCommonSubstring(unittest.TestCase):
    """Unit tests for longest common substring."""

    def test_three_strings(self):
        """Test with three strings."""
        result = longest_common_substring(["ABABC", "BABCA", "ABCBA"])
        self.assertEqual(result, "ABC")

    def test_no_common(self):
        """Test with no common substring."""
        result = longest_common_substring(["abc", "def"])
        self.assertEqual(result, "")

    def test_identical_strings(self):
        """Test with identical strings."""
        result = longest_common_substring(["abc", "abc", "abc"])
        self.assertEqual(result, "abc")

    def test_two_strings(self):
        """Test with two strings."""
        result = longest_common_substring(["hello", "world"])
        self.assertIn(result, ["", "o", "l", "lo"])

    def test_prefix_match(self):
        """Test with prefix matching (2 strings)."""
        result = longest_common_substring(["programming", "proserver"])
        self.assertEqual(result, "pro")

    def test_single_string(self):
        """Test with single string."""
        result = longest_common_substring(["hello"])
        self.assertEqual(result, "hello")

    def test_empty_list(self):
        """Test with empty list."""
        result = longest_common_substring([])
        self.assertEqual(result, "")

    def test_one_empty_string(self):
        """Test with one empty string."""
        result = longest_common_substring(["abc", ""])
        self.assertEqual(result, "")

    def test_length_function(self):
        """Test length function."""
        length = longest_common_substring_length(["ABABC", "BABCA", "ABCBA"])
        self.assertEqual(length, 3)

    def test_get_all_common(self):
        """Test getting all common substrings."""
        result = get_all_common_substrings(["ABABC", "BABCA", "ABCBA"])
        self.assertIn("ABC", result)
        self.assertEqual(result[0], "ABC")


if __name__ == "__main__":
    unittest.main()
