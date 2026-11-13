#!/usr/bin/env python3
"""Line Parser - Perl Weekly Challenge 259 Task 2."""

from __future__ import annotations

import re
from typing import Any
import unittest

TAG_PATTERN = re.compile(
    r"^\s*\{%\s*(?P<name>\w+)(?P<attrs>.*?)\s*%\}"
    r"(?:\r?\n(?P<text>[\s\S]*?)\r?\n\s*\{%\s*end(?P=name)\s*%\})?\s*$",
    re.DOTALL,
)

KV_PATTERN = re.compile(r'(\w+)=(?:(-?\d+(?:\.\d+)?)|"((?:\\.|[^"\\])*)")')


def parse_line(line: str) -> dict[str, Any]:
    """Parse a template tag string and extract tag name, fields, and optional text.

    Args:
        line: Input string containing a single-line or multiline tag.

    Returns:
        A dictionary with 'name', 'fields', and optionally 'text'.
    """
    match = TAG_PATTERN.match(line)
    if not match:
        fallback = re.search(r"\{%\s*(\w+)(.*?)\s*%\}", line, re.DOTALL)
        if not fallback:
            return {}
        name, attrs = fallback.group(1), fallback.group(2)
        text = None
    else:
        name = match.group("name")
        attrs = match.group("attrs")
        text = match.group("text")

    fields: dict[str, Any] = {}
    for kv in KV_PATTERN.finditer(attrs):
        key = kv.group(1)
        if kv.group(2) is not None:
            num_str = kv.group(2)
            fields[key] = float(num_str) if "." in num_str else int(num_str)
        else:
            val_str = kv.group(3)
            fields[key] = re.sub(r"\\(.)", r"\1", val_str)

    result: dict[str, Any] = {"name": name, "fields": fields}
    if text is not None:
        result["text"] = text
    return result


class TestLineParser(unittest.TestCase):
    """Unit tests for parse_line."""

    def test_example_1(self) -> None:
        """Test Example 1: multiple attributes with strings and integer."""
        input_str = '{%  id   field1="value1"    field2="value2"  field3=42 %}'
        expected = {
            "name": "id",
            "fields": {
                "field1": "value1",
                "field2": "value2",
                "field3": 42,
            },
        }
        self.assertEqual(parse_line(input_str), expected)

    def test_example_2_escaped_quotes(self) -> None:
        """Test Example 2: title with escaped double quotes."""
        input_str = r'{%  youtube title="Title \"quoted\" done" %}'
        expected = {
            "name": "youtube",
            "fields": {
                "title": 'Title "quoted" done',
            },
        }
        self.assertEqual(parse_line(input_str), expected)

    def test_example_3_escaped_backslash(self) -> None:
        """Test Example 3: title with escaped backslash."""
        input_str = r'{%  youtube title="Title with escaped backslash \\" %}'
        expected = {
            "name": "youtube",
            "fields": {
                "title": "Title with escaped backslash \\",
            },
        }
        self.assertEqual(parse_line(input_str), expected)

    def test_multiline_tag(self) -> None:
        """Test BONUS: multiline tag with enclosed lines."""
        input_str = """{% id field1="value1" field2="value2" %}
LINES
{% endid %}"""
        expected = {
            "name": "id",
            "fields": {
                "field1": "value1",
                "field2": "value2",
            },
            "text": "LINES",
        }
        self.assertEqual(parse_line(input_str), expected)


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
