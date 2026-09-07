#!/usr/bin/env python3
"""
Perl Weekly Challenge 072 - Task 2: Lines Range

You are given a text file name $file and range $A - $B where $A <= $B.
Write a script to display lines in range $A and $B in the given file.
"""

from pathlib import Path
import tempfile
import unittest


def get_lines_range(file_name: str | Path, a: int, b: int) -> list[str]:
    """Return lines from file within 1-based range [a, b] inclusive without trailing newlines."""
    if a < 1 or b < a:
        return []

    with open(file_name, "r", encoding="utf-8") as f:
        lines = f.readlines()

    # Slice 0-based index [a - 1 : b]
    start_idx = max(0, a - 1)
    end_idx = min(len(lines), b)
    return [line.rstrip("\r\n") for line in lines[start_idx:end_idx]]


class TestLinesRange(unittest.TestCase):
    def setUp(self) -> None:
        self.temp_file = tempfile.NamedTemporaryFile(
            mode="w", delete=False, encoding="utf-8"
        )
        for i in range(1, 21):
            self.temp_file.write(f"L{i}\n")
        self.temp_file.close()

    def tearDown(self) -> None:
        Path(self.temp_file.name).unlink(missing_ok=True)

    def test_range_4_to_12(self) -> None:
        expected = [f"L{i}" for i in range(4, 13)]
        self.assertEqual(get_lines_range(self.temp_file.name, 4, 12), expected)

    def test_range_1_to_3(self) -> None:
        self.assertEqual(
            get_lines_range(self.temp_file.name, 1, 3), ["L1", "L2", "L3"]
        )

    def test_invalid_range(self) -> None:
        self.assertEqual(get_lines_range(self.temp_file.name, 5, 2), [])


if __name__ == "__main__":
    unittest.main()

