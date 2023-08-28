#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest


def binary_flip(n):
    binary = bin(n)[2:]               # Convert to binary
    flipped_binary = binary.translate(
        str.maketrans('01', '10'))  # Flip the bits
    return int(flipped_binary, 2)      # Convert back to decimal


class TestBinaryFlip(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(binary_flip(5), 2)
        self.assertEqual(binary_flip(4), 3)
        self.assertEqual(binary_flip(6), 1)


if __name__ == '__main__':
    unittest.main()
