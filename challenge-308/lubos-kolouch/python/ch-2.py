#!/usr/bin/env python3
"""
Module: xor_decode
Task 2: Decode XOR

Given an encoded array where each element is the XOR of consecutive elements from the original array,
this module provides a function to restore the original array from the encoded array and an initial value.

The encoding is defined as:
    encoded[i] = original[i] XOR original[i+1]

Example:
    Input:  encoded = [1, 2, 3], initial = 1
    Output: [1, 0, 2, 1]
"""

from typing import NewType
import unittest

# Type definitions for clarity
EncodedArray = NewType("EncodedArray", list[int])  # EncodedArray: list of int
OriginalArray = list[int]  # OriginalArray: list of int


def decode_xor(encoded: list[int], initial: int) -> OriginalArray:
    """
    Decode the original array from an encoded array and an initial value.

    The encoded array is defined such that:
        encoded[i] = original[i] XOR original[i+1]

    Args:
        encoded (List[int]): A list of integers representing the XOR encoded array.
        initial (int): The first element of the original array.

    Returns:
        List[int]: The decoded original array.

    Examples:
        >>> decode_xor([1, 2, 3], 1)
        [1, 0, 2, 1]
    """
    original = [initial]
    for value in encoded:
        # The inverse of XOR: original[i+1] = original[i] XOR encoded[i]
        original.append(original[-1] ^ value)
    return original


# Unit tests
class TestDecodeXOR(unittest.TestCase):
    """Unit tests for the decode_xor function."""

    def test_example1(self):
        """Test with first example."""
        self.assertEqual(decode_xor([1, 2, 3], 1), [1, 0, 2, 1])

    def test_example2(self):
        """Test with second example."""
        self.assertEqual(decode_xor([6, 2, 7, 3], 4), [4, 2, 0, 7, 4])

    def test_empty_encoded(self):
        """Test with an empty encoded array."""
        self.assertEqual(decode_xor([], 10), [10])


if __name__ == '__main__':
    unittest.main()
