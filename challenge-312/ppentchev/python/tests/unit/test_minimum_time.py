# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause
"""Unit tests for 312/1, Minimum Time."""

from __future__ import annotations

import typing

import pytest

from pwc_312 import min_time


if typing.TYPE_CHECKING:
    from typing import Final


@pytest.mark.parametrize(
    ("letter", "expected"),
    [
        ("a", 0),
        ("y", min_time.LETTERS - 2),
        ("C", ValueError),
    ],
)
def test_correct_offsets(*, letter: str, expected: int | type[Exception]) -> None:
    """Make sure the `offset()` function returns the correct value."""
    if not isinstance(expected, int):
        with pytest.raises(expected):
            min_time.offset(letter)

        return

    assert min_time.offset(letter) == expected


def calc_distance_clockwise(lfrom: str, lto: str) -> int:
    """Calculate the distance between two letters if going clockwise."""
    if lfrom <= lto:
        return min_time.offset(lto) - min_time.offset(lfrom)

    return min_time.LETTERS - (min_time.offset(lfrom) - min_time.offset(lto))


def calc_distance_counterclockwise(lfrom: str, lto: str) -> int:
    """Calculate the distance between two letters if going counterclockwise."""
    return 0 if lfrom == lto else min_time.LETTERS - calc_distance_clockwise(lfrom, lto)


@pytest.mark.parametrize(
    ("lfrom", "lto", "counter"),
    [
        ("a", "a", False),
        ("a", "b", False),
        ("b", "a", True),
        ("a", "m", False),
        ("m", "a", True),
        ("a", "n", True),
        ("n", "a", True),
    ],
)
def test_correct_distance(*, lfrom: str, lto: str, counter: bool) -> None:
    """Make sure the `distance()` function returns the correct value."""
    if counter:
        assert min_time.distance(lfrom, lto) == calc_distance_counterclockwise(lfrom, lto)
    else:
        assert min_time.distance(lfrom, lto) == calc_distance_clockwise(lfrom, lto)


@pytest.mark.parametrize(
    ("letter", "clockwise", "counterclockwise"),
    [
        ("a", True, False),
        ("b", True, False),
        ("m", True, False),
        ("n", True, True),
        ("o", False, True),
        ("z", False, True),
    ],
)
def test_single_letter(*, letter: str, clockwise: bool, counterclockwise: bool) -> None:
    """Make sure the calculation is correct for a single letter."""
    exp_clockwise: Final = 1 + min_time.offset(letter)
    exp_counterclockwise: Final = 1 + min_time.LETTERS - min_time.offset(letter)
    assert (min_time.typing_time(letter) == exp_clockwise) == clockwise
    assert (min_time.typing_time(letter) == exp_counterclockwise) == counterclockwise


@pytest.mark.parametrize(
    ("word", "expected"),
    [
        ("", 0),
        ("aaa", 3),
        ("abc", 5),
        ("bza", 7),
        ("zjpc", 34),
    ],
)
def test_word(*, word: str, expected: int) -> None:
    """Make sure the calculation is correct for a whole word."""
    assert min_time.typing_time(word) == expected
