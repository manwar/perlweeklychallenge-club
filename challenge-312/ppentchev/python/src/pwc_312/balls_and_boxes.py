# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause
"""Peter Pentchev's solution for 312/2, Balls and Boxes."""

from __future__ import annotations

import collections
import dataclasses
import itertools
import typing


if typing.TYPE_CHECKING:
    from typing import Final


@dataclasses.dataclass
class Balls:
    """A single box of red, green, and blue balls."""

    red: int = 0
    """The number of red balls in this box."""

    green: int = 0
    """The number of green balls in this box."""

    blue: int = 0
    """The number of blue balls in this box."""

    def add_ball(self, color: str) -> None:
        """Add a ball of the specified color."""
        match color:
            case "R":
                self.red += 1

            case "G":
                self.green += 1

            case "B":
                self.blue += 1

            case other:
                raise ValueError(other)

    def is_complete(self) -> bool:
        """Whether we have a full set of ball colors."""
        return self.red > 0 and self.green > 0 and self.blue > 0


def parse(word: str) -> dict[int, Balls]:
    """Parse a specification into a set of boxes."""
    res: Final[collections.defaultdict[int, Balls]] = collections.defaultdict(Balls)

    for color, box_idx_str in itertools.batched(word, 2):
        res[int(box_idx_str)].add_ball(color)

    return dict(res)
