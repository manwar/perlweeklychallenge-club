#!/usr/bin/env python3
"""Perl Weekly Challenge 027 - Task 2: Historical Values.

Capture and display historical values of a variable as it changes over time.
"""

from __future__ import annotations

from typing import Generic, TypeVar
import unittest

T = TypeVar("T")


class HistoricalVar(Generic[T]):
    """A wrapper for a variable that records every assigned value in historical order."""

    def __init__(self, initial_value: T | None = None) -> None:
        """Initialize the historical variable.

        :param initial_value: Initial value, if any.
        """
        self._history: list[T] = []
        if initial_value is not None:
            self.set(initial_value)

    def set(self, value: T) -> T:
        """Assign a new value and record it in history.

        :param value: New value to assign.
        :return: Assigned value.
        """
        self._history.append(value)
        return value

    def get(self) -> T | None:
        """Return the current value.

        :return: Most recent value, or None if uninitialized.
        """
        return self._history[-1] if self._history else None

    @property
    def history(self) -> list[T]:
        """Return a copy of the recorded history.

        :return: List of past values in chronological order.
        """
        return list(self._history)


class TestHistoricalVar(unittest.TestCase):
    """Test cases for HistoricalVar."""

    def test_example(self) -> None:
        # Example: $x = 10; $x = 20; $x -= 5;
        x: HistoricalVar[int] = HistoricalVar(10)
        x.set(20)
        curr = x.get()
        if curr is not None:
            x.set(curr - 5)

        self.assertEqual(x.get(), 15)
        self.assertEqual(x.history, [10, 20, 15])

    def test_strings(self) -> None:
        s: HistoricalVar[str] = HistoricalVar("first")
        s.set("second")
        s.set("third")
        self.assertEqual(s.history, ["first", "second", "third"])


if __name__ == "__main__":
    unittest.main()
