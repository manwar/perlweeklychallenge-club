# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause
"""Peter Pentchev's solution for 312/1, Minimum Time."""

from __future__ import annotations

import functools
import typing


if typing.TYPE_CHECKING:
    from typing import Final


LETTERS: Final = 26
"""The number of lowercase letters in the English alphabet."""


@functools.lru_cache
def offset(letter: str) -> int:
    """Determine the offset from 'a' of a lowercase letter."""
    if letter < "a" or letter > "z":
        raise ValueError(letter)

    return ord(letter) - ord("a")


@functools.lru_cache
def distance(lfrom: str, lto: str) -> int:
    """Calculate the number of moves to get from one letter to another."""
    abs_offset: Final = abs(offset(lfrom) - offset(lto))
    return min(abs_offset, LETTERS - abs_offset)


def _typing_time_single(acc: tuple[str, int], next_letter: str) -> tuple[str, int]:
    """Add a single letter's offset."""
    return next_letter, acc[1] + 1 + distance(acc[0], next_letter)


def typing_time(word: str) -> int:
    """Calculate the total time required to type a word."""
    if not word:
        return 0

    letters: Final = list(word)
    first: Final = letters.pop(0)
    return functools.reduce(_typing_time_single, letters, (first, 1 + distance("a", first)))[1]
