#!/usr/bin/python3
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause
"""Pick a random word from this script's source file and output it."""

from __future__ import annotations

import pathlib
import random
import typing


if typing.TYPE_CHECKING:
    from typing import Final


class EmptyWordError(RuntimeError):
    """An empty word was chosen, `str.split()` is not suppoed to do that."""

    words: list[str]
    """The words among which the empty word was found."""

    def __str__(self) -> str:
        """Provide a human-readable error message."""
        return f"Internal error: empty word in {self.words!r}"


def main() -> None:
    """Find the source file, select a word, output it."""
    words: Final = pathlib.Path(__file__).read_text(encoding="UTF-8").split()
    chosen_one: Final = random.choice(words)  # noqa: S311  # no cryptography here
    if not chosen_one:
        raise EmptyWordError(words)

    print(chosen_one)  # noqa: T201  # this is the whole point of this program


if __name__ == "__main__":
    main()
