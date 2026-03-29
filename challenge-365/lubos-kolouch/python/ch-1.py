#!/usr/bin/env python3
"""Perl Weekly Challenge 365, Task 1: Alphabet Index Digit Sum."""

from __future__ import annotations

import argparse
import sys
from collections.abc import Sequence


def alphabet_index_digit_sum(text: str, k: int) -> int:
    """Convert letters to alphabet positions and sum digits repeatedly k times."""
    number = "".join(str(ord(ch) - 96) for ch in text)
    value = number
    for _ in range(k):
        value = str(sum(int(digit) for digit in value))
    return int(value)


def parse_args(argv: Sequence[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("text", help="lowercase input string")
    parser.add_argument("k", type=int, help="number of digit-sum iterations")
    return parser.parse_args(argv)


def main(argv: Sequence[str] | None = None) -> int:
    args = parse_args(sys.argv[1:] if argv is None else argv)
    print(alphabet_index_digit_sum(args.text, args.k))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
