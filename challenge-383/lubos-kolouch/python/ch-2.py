#!/usr/bin/env python3
"""Nearest RGB - Perl Weekly Challenge 383 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def nearest_rgb(hex_color: str) -> str:
    """Round the RGB channels of a 6-digit hex color to the nearest web-safe value."""
    hex_color = hex_color.lstrip("#").upper()
    if len(hex_color) != 6 or not all(c in "0123456789ABCDEF" for c in hex_color):
        raise ValueError(f"Invalid hex color format: {hex_color}")

    r_dec = int(hex_color[0:2], 16)
    g_dec = int(hex_color[2:4], 16)
    b_dec = int(hex_color[4:6], 16)

    web_safe = [0, 51, 102, 153, 204, 255]

    nearest_r = min(web_safe, key=lambda x: abs(r_dec - x))
    nearest_g = min(web_safe, key=lambda x: abs(g_dec - x))
    nearest_b = min(web_safe, key=lambda x: abs(b_dec - x))

    return f"#{nearest_r:02X}{nearest_g:02X}{nearest_b:02X}"


class NearestRGBExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(nearest_rgb("#F4B2D1"), "#FF99CC")

    def test_example_2(self) -> None:
        self.assertEqual(nearest_rgb("#15E6E5"), "#00FFCC")

    def test_example_3(self) -> None:
        self.assertEqual(nearest_rgb("#191A65"), "#003366")


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit(
        "Usage: python3 ch-2.py\n(Run with no arguments to execute the unit tests)"
    )


if __name__ == "__main__":
    main()
