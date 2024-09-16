# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause
"""Solve the first task in Perl weekly challenge 285, "No Connection"."""

from __future__ import annotations

import dataclasses
import typing

from . import defs


if typing.TYPE_CHECKING:
    from typing import Final


@dataclasses.dataclass
class NoLeafError(defs.NoSolutionError):
    """No leaf destinations at all."""

    def __str__(self) -> str:
        """Provide a human-readable error message."""
        return "No leaf destinations could be found"


@dataclasses.dataclass
class MultipleLeavesError(defs.NoSolutionError):
    """More than one leaf destination."""

    multiple: list[str]
    """The leaf destinations found."""

    def __str__(self) -> str:
        """Provide a human-readable error message."""
        return f"Multiple leaf destinations found: {self.multiple!r}"


def solve_no_connection(routes: list[tuple[str, str]]) -> str:
    """Solve the first task, "No Connection."""
    loc_from: Final = {item[0] for item in routes}
    loc_to: Final = {item[1] for item in routes}
    match sorted(loc_to - loc_from):
        case []:
            raise NoLeafError

        case [single]:
            return single

        case multiple:
            raise MultipleLeavesError(multiple)
