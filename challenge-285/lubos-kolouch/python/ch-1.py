#!/usr/bin/env python3
"""No Connection - The Weekly Challenge 285 Task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def find_destination(routes: Sequence[Sequence[str]]) -> str | None:
    """Find the destination with no further outgoing connection from routes.

    Each route is represented as a pair containing a source and destination city.

    Args:
        routes: A sequence of routes, where each route is [source, destination].

    Returns:
        The destination city with no outgoing connections, or None if none exists.
    """
    sources: set[str] = set()
    destinations: set[str] = set()

    for route in routes:
        source, destination = route
        sources.add(source)
        destinations.add(destination)

    no_outgoing = sorted(destinations - sources)
    if no_outgoing:
        return no_outgoing[0]
    return None


class TestNoConnection(unittest.TestCase):
    """Unit tests for find_destination."""

    def test_example1(self) -> None:
        """Test Example 1: [["B", "C"], ["D", "B"], ["C", "A"]] -> "A"."""
        routes = [["B", "C"], ["D", "B"], ["C", "A"]]
        self.assertEqual(find_destination(routes), "A")

    def test_example2(self) -> None:
        """Test Example 2: [["A", "Z"]] -> "Z"."""
        routes = [["A", "Z"]]
        self.assertEqual(find_destination(routes), "Z")

    def test_no_destination(self) -> None:
        """Test circular routes with no terminal destination."""
        routes = [["A", "B"], ["B", "A"]]
        self.assertIsNone(find_destination(routes))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        parsed_routes = [arg.split(",", 1) for arg in argv[1:]]
        print(f"Output: {find_destination(parsed_routes)}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
