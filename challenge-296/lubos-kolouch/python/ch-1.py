#!/usr/bin/env python3
"""String Compression and Decompression - Perl Weekly Challenge 296 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def compress_string(chars: str) -> str:
    """Compress the input string using run-length encoding."""
    compressed = ""
    n = len(chars)
    i = 0
    while i < n:
        current_char = chars[i]
        count = 1
        while i + 1 < n and chars[i + 1] == current_char:
            count += 1
            i += 1
        if count > 1:
            compressed += f"{count}{current_char}"
        else:
            compressed += current_char
        i += 1
    return compressed


def decompress_string(compressed: str) -> str:
    """Decompress the compressed string back to its original form."""
    decompressed = ""
    n = len(compressed)
    i = 0
    while i < n:
        if compressed[i].isdigit():
            count = ""
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


class TestStringCompression(unittest.TestCase):
    """Unit tests for compress_string and decompress_string."""

    def test_example1_compress(self) -> None:
        """Test example 1 compression."""
        self.assertEqual(compress_string("abbc"), "a2bc")

    def test_example2_compress(self) -> None:
        """Test example 2 compression."""
        self.assertEqual(compress_string("aaabccc"), "3ab3c")

    def test_example3_compress(self) -> None:
        """Test example 3 compression."""
        self.assertEqual(compress_string("abcc"), "ab2c")

    def test_example1_decompress(self) -> None:
        """Test example 1 decompression."""
        self.assertEqual(decompress_string("a2bc"), "abbc")

    def test_example2_decompress(self) -> None:
        """Test example 2 decompression."""
        self.assertEqual(decompress_string("3ab3c"), "aaabccc")

    def test_example3_decompress(self) -> None:
        """Test example 3 decompression."""
        self.assertEqual(decompress_string("ab2c"), "abcc")

    def test_additional(self) -> None:
        """Test additional compression and decompression."""
        self.assertEqual(compress_string("aaabbbaaa"), "3a3b3a")
        self.assertEqual(decompress_string("3a3b3a"), "aaabbbaaa")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    _ = argv
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main()
