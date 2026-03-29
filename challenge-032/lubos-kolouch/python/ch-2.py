#!/usr/bin/env python3
"""Challenge 032 - Task 2: ASCII bar chart.

Generate a simple bar chart from a mapping of labels to numeric values.
By default the chart is ordered by labels; pass --order values to sort by
value descending (with label as a tie-breaker).
"""

from __future__ import annotations

import json
import sys
from typing import Mapping

SAMPLE_DATA: dict[str, float] = {"apple": 3, "cherry": 2, "banana": 1}


def generate_bar_graph(data: Mapping[str, float], order: str = "labels") -> list[str]:
    """Return formatted bar-chart lines for the supplied data."""
    if not data:
        return []

    labels = list(data)
    width = max(len(label) for label in labels)

    if order == "values":
        items = sorted(data.items(), key=lambda item: (-item[1], item[0]))
    else:
        items = sorted(data.items())

    return [f"{label:>{width}} | {'#' * int(value)}" for label, value in items]


def load_data_from_stdin() -> dict[str, float]:
    """Load a JSON object from stdin, or return the sample data on empty input."""
    raw = sys.stdin.read().strip()
    if not raw:
        return SAMPLE_DATA
    data = json.loads(raw)
    if not isinstance(data, dict):
        raise ValueError("Input must be a JSON object of label -> value")
    return {str(key): float(value) for key, value in data.items()}


def main(argv: list[str]) -> int:
    """Command-line entry point."""
    order = "labels"
    if len(argv) > 1 and argv[1] == "--order":
        if len(argv) < 3:
            print(f"Usage: {argv[0]} [--order labels|values]")
            return 1
        order = argv[2]

    data = load_data_from_stdin()
    for line in generate_bar_graph(data, order=order):
        print(line)
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
