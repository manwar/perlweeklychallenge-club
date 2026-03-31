#!/usr/bin/env python3
"""Challenge 029 - Task 1: Brace expansion.

Expand expressions like:
    Perl {Daily,Weekly,Monthly,Yearly} Challenge
into multiple lines.
"""

from __future__ import annotations

import re
import sys
from typing import Iterable, List

BRACE_RE = re.compile(r"\{([^{}]*)\}")


def expand_braces(text: str) -> list[str]:
    """Recursively expand one brace group at a time."""
    match = BRACE_RE.search(text)
    if match is None:
        return [text]

    before = text[: match.start()]
    choices = match.group(1).split(",")
    after = text[match.end() :]

    result: list[str] = []
    for choice in choices:
        result.extend(expand_braces(before + choice + after))
    return result


def main(argv: list[str]) -> int:
    """Command-line entry point."""
    if len(argv) < 2:
        print(f"Usage: {argv[0]} TEXT")
        return 1

    for line in expand_braces(" ".join(argv[1:])):
        print(line)
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
