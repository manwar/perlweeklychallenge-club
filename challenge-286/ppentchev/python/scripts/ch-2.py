#!/usr/bin/python3
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause
"""Pick a random word from this script's source file and output it."""

from __future__ import annotations

import enum
import os
import sys
import typing


if typing.TYPE_CHECKING:
    from collections.abc import Callable, Iterable, Iterator
    from typing import Final, Self


TEST_SEQUENCES: Final = [
    [2, 1, 4, 5, 6, 3, 0, 2],
    [0, 5, 3, 2],
    [9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8],
]
"""The sample sequences from the problem."""


class OrderIterState(enum.IntEnum):
    """The states that an `OrderIter` object may be in."""

    STASH = 0
    """Stash a value to pass to `min()` or `max()` later."""

    YIELD = 1
    """Perform a `min()` or `max()` operation, yield the result."""


class OrderIter:
    """Iterate over the numbers of a single round."""

    ints: Iterator[int]
    """The list of integers to process."""

    state: OrderIterState
    """The current state of the iterator."""

    stashed: int
    """The last stashed number."""

    op: Callable[[int, int], int]
    """The operation to perform when yielding a value."""

    def __init__(self, ints: Iterable[int]) -> None:
        """Construct an `OrderIter` object with the specified numbers to process."""
        self.ints = iter(ints)
        self.state = OrderIterState.STASH
        self.stashed = -616
        self.op = min

    def __iter__(self) -> Self:
        """Return the `OrderIter` object itself as an iterator."""
        return self

    def __next__(self) -> int:
        """Calculate and return the next number."""
        match self.state:
            case OrderIterState.STASH:
                self.stashed = next(self.ints)
                self.state = OrderIterState.YIELD
                return next(self)

            case OrderIterState.YIELD:
                res: Final = self.op(self.stashed, next(self.ints))
                self.state = OrderIterState.STASH
                self.op = max if self.op == min else min
                return res


def order_iter(ints: list[int]) -> list[int]:
    """Run a single round using an `OrderIter` object."""
    return list(OrderIter(ints))


def run_order_game(ints: list[int]) -> int:
    """Run the order game until there is only a single integer left."""
    if not ints:
        raise RuntimeError(repr(ints))

    while len(ints) > 1:
        ints = order_iter(ints)

    return ints[0]


def parse_stdin() -> list[int]:
    """Read a line from the standard input, parse it as a list of integers."""
    return [int(word) for word in sys.stdin.readline().split() if word]


def main() -> None:
    """Find the source file, select a word, output it."""
    if os.environ.get("PWC_FROM_STDIN", "") == "1":
        print(run_order_game(parse_stdin()))  # noqa: T201  # this is the whole point
    else:
        for ints in TEST_SEQUENCES:
            print(run_order_game(ints))  # noqa: T201  # this is the whole point


if __name__ == "__main__":
    main()
