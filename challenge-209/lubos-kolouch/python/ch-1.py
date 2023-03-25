#!/usr/bin/env python
# -*- coding: utf-8 -*-
from typing import List


def decode_bits(bits: List[int]) -> List[str]:
    """
    Decode a list of binary bits into characters according to the following rules:
    [0] -> 'a'
    [1, 0] -> 'b'
    [1, 1] -> 'c'
    Args:
        bits: A list of binary bits ending with 0.
    Returns:
        A list of characters decoded from the binary bits.
    """
    decoded = []
    i = 0
    while i < len(bits):
        if bits[i] == 0:
            decoded.append('a')
            i += 1
        elif bits[i] == 1 and bits[i + 1] == 0:
            decoded.append('b')
            i += 2
        elif bits[i] == 1 and bits[i + 1] == 1:
            decoded.append('c')
            i += 2
    return decoded


def is_last_character_a(bits: List[int]) -> int:
    """
    Check if the last character decoded from the binary bits is 'a'.
    Args:
        bits: A list of binary bits ending with 0.
    Returns:
        1 if the last character decoded is 'a', 0 otherwise.
    """
    decoded = decode_bits(bits)
    return 1 if decoded[-1] == 'a' else 0


import unittest


class TestDecodeBits(unittest.TestCase):

    def test_decode_bits(self):
        self.assertEqual(decode_bits([1, 0, 0]), ['b', 'a'])
        self.assertEqual(decode_bits([1, 1, 1, 0]), ['c', 'b'])

    def test_is_last_character_a(self):
        self.assertEqual(is_last_character_a([1, 0, 0]), 1)
        self.assertEqual(is_last_character_a([1, 1, 1, 0]), 0)


if __name__ == '__main__':
    unittest.main()
