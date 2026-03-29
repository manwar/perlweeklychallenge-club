#!/usr/bin/env python3
"""Perl Weekly Challenge 365, Task 2: Valid Token Counter."""

from __future__ import annotations

import argparse
import re
import sys
from collections.abc import Sequence

VALID_TOKEN_RE = re.compile(r"^[a-z]+(?:-[a-z]+)?[!.,]?$")


def valid_token_count(sentence: str) -> int:
    """Count tokens that satisfy the task's lowercase / hyphen / punctuation rules."""
    return sum(1 for token in sentence.split() if VALID_TOKEN_RE.fullmatch(token))


def parse_args(argv: Sequence[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("sentence", help="space-separated sentence to analyse")
    return parser.parse_args(argv)


def main(argv: Sequence[str] | None = None) -> int:
    args = parse_args(sys.argv[1:] if argv is None else argv)
    print(valid_token_count(args.sentence))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
