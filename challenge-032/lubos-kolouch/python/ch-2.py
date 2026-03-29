#!/usr/bin/env python3
"""Perl Weekly Challenge 032 - Task 2: ASCII bar chart."""

from __future__ import annotations

import json
import sys
from typing import Mapping, Sequence


SAMPLE_DATA: dict[str, float] = {"apple": 3, "cherry": 2, "banana": 1}


def render_bar_graph(
    data: Mapping[str, float],
    *,
    order_by: str = "value",
    scale: int = 4,
) -> str:
    """Render a simple ASCII bar graph from label/value pairs."""
    if not data:
        return ""

    if order_by == "value":
        items = sorted(data.items(), key=lambda pair: (-pair[1], pair[0]))
    else:
        items = sorted(data.items(), key=lambda pair: pair[0])

    width = max(len(label) for label in data)
    lines = [
        f"{label:>{width}} | {'#' * max(0, int(round(value * scale)))}"
        for label, value in items
    ]
    return "\n".join(lines)


def _load_data_from_json(text: str) -> dict[str, float]:
    payload = json.loads(text)
    if not isinstance(payload, dict):
        raise ValueError("JSON input must be an object mapping labels to numbers")
    data: dict[str, float] = {}
    for key, value in payload.items():
        data[str(key)] = float(value)
    return data


def main(argv: Sequence[str] | None = None) -> int:
    """CLI entry point."""
    args = list(sys.argv[1:] if argv is None else argv)
    order_by = "value"
    if args[:2] == ["--order", "value"]:
        order_by = "value"
        args = args[2:]
    elif args[:2] == ["--order", "label"]:
        args = args[2:]

    if args[:2] == ["--json", "-"]:
        data = _load_data_from_json(sys.stdin.read())
    elif len(args) >= 2 and args[0] == "--json":
        with open(args[1], encoding="utf-8") as handle:
            data = _load_data_from_json(handle.read())
    else:
        data = SAMPLE_DATA

    chart = render_bar_graph(data, order_by=order_by)
    if chart:
        print(chart)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
