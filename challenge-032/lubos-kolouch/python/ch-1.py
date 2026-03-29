#!/usr/bin/env python3
"""Challenge 032 - Task 1: Count instances.

Read standard input or one or more files and count how many times each line
appears. Print the summary sorted by count, with ties broken alphabetically.
Use -csv to emit CSV instead of a padded table.
"""

from __future__ import annotations

import fileinput
import sys
from collections import Counter
from typing import Iterable


def count_instances(paths: list[str] | None = None) -> Counter[str]:
    """Count stripped lines from stdin or the given files."""
    counter: Counter[str] = Counter()
    for line in fileinput.input(files=paths):
        word = line.strip()
        if word:
            counter[word] += 1
    return counter


def format_table(counter: Counter[str]) -> list[str]:
    """Format counts as a right-aligned table sorted by count desc, label asc."""
    if not counter:
        return []

    width = max(len(word) for word in counter)
    rows = sorted(counter.items(), key=lambda item: (-item[1], item[0]))
    return [f"{word:<{width}}\t{count}" for word, count in rows]


def format_csv(counter: Counter[str]) -> list[str]:
    """Format counts as CSV sorted by label, matching the extra-credit example."""
    return [f"{word},{count}" for word, count in sorted(counter.items())]


def main(argv: list[str]) -> int:
    """Command-line entry point."""
    args = argv[1:]
    csv_mode = False
    if args and args[0] == "-csv":
        csv_mode = True
        args = args[1:]

    counter = count_instances(args or None)
    lines = format_csv(counter) if csv_mode else format_table(counter)
    for line in lines:
        print(line)
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
