#!/usr/bin/env python3
"""Challenge 366, Task 1: Count Prefixes.

Count how many words in a list are prefixes of the given string.
"""

from __future__ import annotations

import json
import sys
from collections.abc import Sequence


def count_prefixes(words: Sequence[str], text: str) -> int:
    """Return the number of words that are prefixes of *text*."""
    return sum(text.startswith(word) for word in words)


def _run_examples() -> int:
    examples = [
        (["a", "ap", "app", "apple", "banana"], "apple", 4),
        (["cat", "dog", "fish"], "bird", 0),
        (["hello", "he", "hell", "heaven", "he"], "hello", 4),
        (["", "code", "coding", "cod"], "coding", 3),
        (["p", "pr", "pro", "prog", "progr", "progra", "program"], "program", 7),
    ]
    for words, text, expected in examples:
        actual = count_prefixes(words, text)
        if actual != expected:
            raise AssertionError((words, text, actual, expected))
        print(actual)
    return 0


def main(argv: list[str]) -> int:
    """Command-line entry point."""
    if len(argv) == 1:
        return _run_examples()

    if len(argv) < 3:
        print('Usage: ch-1.py \'["a", "ap"]\' apple', file=sys.stderr)
        return 1

    words = json.loads(argv[1])
    if not isinstance(words, list) or not all(isinstance(word, str) for word in words):
        raise TypeError("First argument must be a JSON array of strings")

    print(count_prefixes(words, argv[2]))
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
