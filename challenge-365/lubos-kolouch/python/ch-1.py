#!/usr/bin/env python3
"""
Alphabet Index Digit Sum

Convert a string to numbers using alphabet positions, concatenate them,
then compute the sum of its digits repeatedly K times.

Example:
    Input: "abc", k=1
    Conversion: a=1, b=2, c=3 -> 123
    Digit sum: 1+2+3 = 6
    Output: 6
"""

import unittest


def alphabet_index_digit_sum(text: str, k: int) -> int:
    """
    Convert string to numbers, sum digits K times.

    Args:
        text: String of lowercase English letters.
        k: Number of times to sum digits.

    Returns:
        The final digit sum after K iterations.

    Raises:
        ValueError: If text is empty or k is not positive.
    """
    if not text:
        raise ValueError("text must not be empty")
    if k < 1:
        raise ValueError("k must be a positive integer")

    numbers: str = ""
    for char in text:
        if not ("a" <= char <= "z"):
            raise ValueError(f"Invalid character: {char}")
        num = ord(char) - ord("a") + 1
        numbers += str(num)

    digit_sum = sum(int(d) for d in numbers)

    for _ in range(2, k + 1):
        digit_sum = sum(int(d) for d in str(digit_sum))

    return digit_sum


def _digit_sum(num: int) -> int:
    """
    Helper function to sum digits of a number.

    Args:
        num: Non-negative integer.

    Returns:
        Sum of digits.
    """
    return sum(int(d) for d in str(num))


class TestAlphabetIndexDigitSum(unittest.TestCase):
    """Unit tests for alphabet_index_digit_sum function."""

    def test_example_1(self):
        """abc, k=1 -> 6"""
        self.assertEqual(alphabet_index_digit_sum("abc", 1), 6)

    def test_example_2(self):
        """az, k=2 -> 9"""
        self.assertEqual(alphabet_index_digit_sum("az", 2), 9)

    def test_example_3(self):
        """cat, k=1 -> 6"""
        self.assertEqual(alphabet_index_digit_sum("cat", 1), 6)

    def test_example_4(self):
        """dog, k=2 -> 8"""
        self.assertEqual(alphabet_index_digit_sum("dog", 2), 8)

    def test_example_5(self):
        """perl, k=3 -> 6"""
        self.assertEqual(alphabet_index_digit_sum("perl", 3), 6)

    def test_single_letter(self):
        """Single letter 'a' should return 1"""
        self.assertEqual(alphabet_index_digit_sum("a", 1), 1)

    def test_double_letter(self):
        """'ab' -> 12, sum=3"""
        self.assertEqual(alphabet_index_digit_sum("ab", 1), 3)

    def test_z(self):
        """'z' -> 26, sum=8"""
        self.assertEqual(alphabet_index_digit_sum("z", 1), 8)

    def test_invalid_character(self):
        """Should raise ValueError for non-lowercase character"""
        with self.assertRaises(ValueError):
            alphabet_index_digit_sum("abc1", 1)

    def test_empty_string(self):
        """Should raise ValueError for empty string"""
        with self.assertRaises(ValueError):
            alphabet_index_digit_sum("", 1)

    def test_invalid_k(self):
        """Should raise ValueError for k < 1"""
        with self.assertRaises(ValueError):
            alphabet_index_digit_sum("abc", 0)


if __name__ == "__main__":
    unittest.main()
