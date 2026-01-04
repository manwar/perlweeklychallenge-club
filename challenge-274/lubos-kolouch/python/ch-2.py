#!/usr/bin/env python3
"""Bus Route - Perl Weekly Challenge 274 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


Route = tuple[int, int, int]  # interval, offset, duration


def _next_departure(t: int, interval: int, offset: int) -> int:
    if t <= offset:
        return offset
    k = (t - offset + interval - 1) // interval
    return offset + k * interval


def bus_route(routes: Sequence[Route]) -> list[int]:
    """Return minutes t (0..59) where waiting for a later bus gets you in sooner."""
    if not routes:
        raise ValueError("Expected at least one route")

    bad: list[int] = []
    for t in range(60):
        dmin: int | None = None
        best_at_dmin: int | None = None
        best_arrival: int | None = None
        best_departure: int | None = None

        for interval, offset, duration in routes:
            dep = _next_departure(t, interval, offset)
            arr = dep + duration

            if dmin is None or dep < dmin:
                dmin = dep
                best_at_dmin = arr
            elif dep == dmin:
                assert best_at_dmin is not None
                best_at_dmin = min(best_at_dmin, arr)

            if best_arrival is None or arr < best_arrival:
                best_arrival = arr
                best_departure = dep

        assert dmin is not None and best_at_dmin is not None and best_arrival is not None and best_departure is not None
        if best_departure > dmin and best_arrival < best_at_dmin:
            bad.append(t)

    return bad


class BusRouteExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(bus_route(((12, 11, 41), (15, 5, 35))), list(range(36, 48)))

    def test_example_2(self) -> None:
        self.assertEqual(
            bus_route(((12, 3, 41), (15, 9, 35), (30, 5, 25))),
            [0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 55, 56, 57, 58, 59],
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface.

    Usage: python3 ch-2.py <interval offset duration>...
    """
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) % 3 != 0:
        raise SystemExit("Usage: python3 ch-2.py <interval offset duration>...")

    routes: list[Route] = []
    for i in range(0, len(args), 3):
        routes.append((int(args[i]), int(args[i + 1]), int(args[i + 2])))

    out = bus_route(routes)
    print(f"Output: [ {', '.join(str(x) for x in out)} ]")


if __name__ == "__main__":
    main()

