#!/usr/bin/env python

import unittest


def compress_string(chars: str) -> str:
    """
    Compresses the input string using run-length encoding as per the problem statement.

    For each group of consecutive identical characters:
    - If the count is 1, output the character.
    - If the count is greater than 1, output the count followed by the character.

    Args:
        chars (str): The input string consisting of alphabetic characters.

    Returns:
        str: The compressed string.
    """
    compressed = ''
    n = len(chars)
    i = 0
    while i < n:
        current_char = chars[i]
        count = 1
        while i + 1 < n and chars[i + 1] == current_char:
            count += 1
            i += 1
        if count > 1:
            compressed += str(count) + current_char
        else:
            compressed += current_char
        i += 1
    return compressed


def decompress_string(compressed: str) -> str:
    """
    Decompresses the compressed string back to its original form.

    Args:
        compressed (str): The compressed string.

    Returns:
        str: The original uncompressed string.
    """
    decompressed = ''
    n = len(compressed)
    i = 0
    while i < n:
        if compressed[i].isdigit():
            # Collect the full number (in case of multiple digits)
            count = ''
            while i < n and compressed[i].isdigit():
                count += compressed[i]
                i += 1
            char = compressed[i]
            decompressed += char * int(count)
            i += 1
        else:
            decompressed += compressed[i]
            i += 1
    return decompressed


# Unit Tests


class TestStringCompression(unittest.TestCase):

    def test_example1_compress(self):
        self.assertEqual(compress_string("abbc"), "a2bc", 'Example 1 Compression')

    def test_example2_compress(self):
        self.assertEqual(compress_string("aaabccc"), "3ab3c", 'Example 2 Compression')

    def test_example3_compress(self):
        self.assertEqual(compress_string("abcc"), "ab2c", 'Example 3 Compression')

    def test_example1_decompress(self):
        self.assertEqual(decompress_string("a2bc"), "abbc", 'Example 1 Decompression')

    def test_example2_decompress(self):
        self.assertEqual(decompress_string("3ab3c"), "aaabccc", 'Example 2 Decompression')

    def test_example3_decompress(self):
        self.assertEqual(decompress_string("ab2c"), "abcc", 'Example 3 Decompression')

    def test_additional(self):
        self.assertEqual(compress_string("aaabbbaaa"), "3a3b3a", 'Additional Compression')
        self.assertEqual(decompress_string("3a3b3a"), "aaabbbaaa", 'Additional Decompression')


if __name__ == "__main__":
    unittest.main()
