#!/usr/bin/env python3
"""Perl Weekly Challenge 032 - Task 1: Count instances."""

from __future__ import annotations

from collections import Counter
import fileinput
import sys
from typing import Iterable, Mapping, Sequence


def count_instances(lines: Iterable[str]) -> Counter[str]:
    """Count non-empty stripped entries from an input stream."""
    counts: Counter[str] = Counter()
    for line in lines:
        item = line.strip()
        if item:
            counts[item] += 1
    return counts


def format_counts(counts: Mapping[str, int], csv: bool = False) -> list[str]:
    """Format counts sorted by frequency descending and name ascending."""
    separator = "," if csv else "\t"
    return [
        f"{item}{separator}{count}"
        for item, count in sorted(counts.items(), key=lambda pair: (-pair[1], pair[0]))
    ]


def main(argv: Sequence[str] | None = None) -> int:
    """CLI entry point."""
    args = list(sys.argv[1:] if argv is None else argv)
    csv_output = False
    if args and args[0] == "-csv":
        csv_output = True
        args = args[1:]

    counts = count_instances(fileinput.input(files=args or ("-",), encoding="utf-8"))
    for line in format_counts(counts, csv_output):
        print(line)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
