# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause
"""Test the second task in Perl weekly challenge 285, "Making Change"."""

from __future__ import annotations

import dataclasses

import pytest

from perl_weekly_285 import change


@dataclasses.dataclass(frozen=True)
class BreakDownWaysCase:
    """A test case for the "No Connection" task."""

    amount: int
    """The amount to break down."""

    highest: change.Coin
    """The highest coin to use for this amount."""

    expected: list[tuple[int, change.Coin]]
    """The ways to break this amount down into smaller chunks."""


@pytest.mark.parametrize(
    "tcase",
    [
        BreakDownWaysCase(amount=1, highest=change.Coin.HALF_DOLLAR, expected=[]),
        BreakDownWaysCase(amount=2, highest=change.Coin.HALF_DOLLAR, expected=[]),
        BreakDownWaysCase(
            amount=6,
            highest=change.Coin.HALF_DOLLAR,
            expected=[(1, change.Coin.PENNY)],
        ),
        BreakDownWaysCase(amount=6, highest=change.Coin.NICKEL, expected=[(1, change.Coin.PENNY)]),
        BreakDownWaysCase(amount=6, highest=change.Coin.PENNY, expected=[]),
        BreakDownWaysCase(
            amount=7,
            highest=change.Coin.HALF_DOLLAR,
            expected=[(2, change.Coin.PENNY)],
        ),
        BreakDownWaysCase(amount=7, highest=change.Coin.NICKEL, expected=[(2, change.Coin.PENNY)]),
        BreakDownWaysCase(amount=7, highest=change.Coin.PENNY, expected=[]),
        BreakDownWaysCase(
            amount=10,
            highest=change.Coin.HALF_DOLLAR,
            expected=[(0, change.Coin.NICKEL), (5, change.Coin.PENNY), (0, change.Coin.PENNY)],
        ),
        BreakDownWaysCase(
            amount=10,
            highest=change.Coin.DIME,
            expected=[(0, change.Coin.NICKEL), (5, change.Coin.PENNY), (0, change.Coin.PENNY)],
        ),
        BreakDownWaysCase(
            amount=10,
            highest=change.Coin.NICKEL,
            expected=[(5, change.Coin.PENNY), (0, change.Coin.PENNY)],
        ),
        BreakDownWaysCase(amount=10, highest=change.Coin.PENNY, expected=[]),
        BreakDownWaysCase(
            amount=12,
            highest=change.Coin.HALF_DOLLAR,
            expected=[(2, change.Coin.NICKEL), (7, change.Coin.PENNY), (2, change.Coin.PENNY)],
        ),
        BreakDownWaysCase(
            amount=12,
            highest=change.Coin.DIME,
            expected=[(2, change.Coin.NICKEL), (7, change.Coin.PENNY), (2, change.Coin.PENNY)],
        ),
        BreakDownWaysCase(
            amount=12,
            highest=change.Coin.NICKEL,
            expected=[(7, change.Coin.PENNY), (2, change.Coin.PENNY)],
        ),
        BreakDownWaysCase(amount=12, highest=change.Coin.PENNY, expected=[]),
        BreakDownWaysCase(
            amount=15,
            highest=change.Coin.HALF_DOLLAR,
            expected=[
                (5, change.Coin.NICKEL),
                (10, change.Coin.PENNY),
                (5, change.Coin.PENNY),
                (0, change.Coin.PENNY),
            ],
        ),
        BreakDownWaysCase(
            amount=15,
            highest=change.Coin.DIME,
            expected=[
                (5, change.Coin.NICKEL),
                (10, change.Coin.PENNY),
                (5, change.Coin.PENNY),
                (0, change.Coin.PENNY),
            ],
        ),
        BreakDownWaysCase(
            amount=15,
            highest=change.Coin.NICKEL,
            expected=[(10, change.Coin.PENNY), (5, change.Coin.PENNY), (0, change.Coin.PENNY)],
        ),
        BreakDownWaysCase(amount=15, highest=change.Coin.PENNY, expected=[]),
    ],
)
def test_break_down_ways(*, tcase: BreakDownWaysCase) -> None:
    """Make sure we can find the leaf destination."""
    assert change.break_down_ways(tcase.amount, tcase.highest) == tcase.expected


@dataclasses.dataclass(frozen=True)
class MakeChangeCase:
    """A test case for the actual "how many ways can we break this down" function."""

    amount: int
    """The amount to break down."""

    expected: int
    """The expected number of ways."""


@pytest.mark.parametrize(
    "tcase",
    [
        MakeChangeCase(amount=9, expected=2),
        MakeChangeCase(amount=15, expected=6),
        MakeChangeCase(amount=100, expected=292),
    ],
)
def test_make_change(tcase: MakeChangeCase) -> None:
    """Make sure we can count the ways."""
    assert change.solve_making_change(tcase.amount) == tcase.expected
