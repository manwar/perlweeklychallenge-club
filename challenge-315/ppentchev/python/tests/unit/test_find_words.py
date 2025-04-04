# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause
"""Unit tests for weekly challenge 315 task 1 - find words."""

from __future__ import annotations

import dataclasses
import typing

import pytest

from pwc315 import find_words


if typing.TYPE_CHECKING:
    from typing import Final


@dataclasses.dataclass(frozen=True)
class FindWordsCase:
    """A single test case for finding a character in words."""

    wlist: list[str]
    """The words to search."""

    wchar: str
    """The character to look for."""

    expected: list[int]
    """The expected indices to find the character at."""


FIND_WORDS_CASES: Final = [
    FindWordsCase(["perl", "raku", "python"], "p", [0, 2]),
]


@pytest.mark.parametrize("tcase", FIND_WORDS_CASES)
def test_find_words(tcase: FindWordsCase) -> None:
    """Make sure the character is found exactly as expected."""
    assert find_words.find_words(tcase.wlist, tcase.wchar) == tcase.expected
