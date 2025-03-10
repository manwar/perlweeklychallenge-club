# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause
"""Unit tests for 312/2, Balls and Boxes."""

from __future__ import annotations

import typing

import pytest

from pwc_312 import balls_and_boxes


if typing.TYPE_CHECKING:
    from typing import Final


TEST_DATA: Final = [
    ("", 0, {}),
    ("R3", 0, {3: balls_and_boxes.Balls(red=1)}),
    (
        "G0B1R2R0B0",
        1,
        {
            0: balls_and_boxes.Balls(red=1, green=1, blue=1),
            1: balls_and_boxes.Balls(blue=1),
            2: balls_and_boxes.Balls(red=1),
        },
    ),
    (
        "G1R3R6B3G6B1B6R1G3",
        3,
        {
            1: balls_and_boxes.Balls(red=1, green=1, blue=1),
            3: balls_and_boxes.Balls(red=1, green=1, blue=1),
            6: balls_and_boxes.Balls(red=1, green=1, blue=1),
        },
    ),
    (
        "B3B2G1B3",
        0,
        {
            1: balls_and_boxes.Balls(green=1),
            2: balls_and_boxes.Balls(blue=1),
            3: balls_and_boxes.Balls(blue=2),
        },
    ),
]


@pytest.mark.parametrize(("word", "expected", "balls"), TEST_DATA)
def test_parse(
    *,
    word: str,
    expected: bool,  # noqa: ARG001
    balls: dict[int, balls_and_boxes.Balls],
) -> None:
    """Make sure the `parse()` function works correctly."""
    assert balls_and_boxes.parse(word) == balls


@pytest.mark.parametrize(("word", "expected", "balls"), TEST_DATA)
def test_count(
    *,
    word: str,
    expected: bool,
    balls: dict[int, balls_and_boxes.Balls],  # noqa: ARG001
) -> None:
    """Make sure we expect the correct number of well-rounded boxes."""
    all_boxes: Final = balls_and_boxes.parse(word).values()
    assert expected == len([box for box in all_boxes if box.is_complete()])
