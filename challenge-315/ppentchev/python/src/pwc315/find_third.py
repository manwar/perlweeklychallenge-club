# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause
"""Weekly challenge 315 task 2 - find words following the specified two."""

from __future__ import annotations

import functools
import re
import typing


if typing.TYPE_CHECKING:
    from typing import Final


RE_NOT_LETTER: Final = re.compile(r" [^A-Za-z0-9]+ ", re.X)


def find_third(sentence: str, wfirst: str, wsecond: str) -> list[str]:
    """Find the words immediately following the specified two in the sentence."""

    def single(acc: tuple[list[str], str, str], word: str) -> tuple[list[str], str, str]:
        """Handle a single word."""
        res, cfirst, csecond = acc
        if cfirst == wfirst and csecond == wsecond:
            res.append(word)

        return res, csecond, word

    words: Final[list[str]] = [word for word in re.split(RE_NOT_LETTER, sentence) if word]
    try:
        cfirst = words.pop(0)
        csecond = words.pop(0)
    except IndexError:
        return []
    assert isinstance(cfirst, str)  # noqa: S101  # mypy needs this
    assert isinstance(csecond, str)  # noqa: S101  # mypy needs this

    res_init: Final[list[str]] = []
    return functools.reduce(single, words, (res_init, cfirst, csecond))[0]
