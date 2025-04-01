# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause
"""Weekly challenge 315 task 1 - find words containing the specified character."""

from __future__ import annotations


def find_words(wlist: list[str], wchar: str) -> list[int]:
    """Find the indices of the words containing the specified character."""
    return [idx for idx, word in enumerate(wlist) if wchar in word]
