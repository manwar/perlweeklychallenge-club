# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause
"""Common definitions for the perl-weekly-285 library."""

from __future__ import annotations

import dataclasses
import typing


if typing.TYPE_CHECKING:
    from typing import Final


VERSION: Final = "0.1.0"
"""The perl-weekly-285 library version, semver-like."""


@dataclasses.dataclass
class Error(Exception):
    """An error that occurred during the processing."""

    def __str__(self) -> str:
        """Provide a human-readable error message."""
        return f"{type(self).__str__} must be overridden for {self!r}"


@dataclasses.dataclass
class NoSolutionError(Error):
    """No solution could be found."""

    def __str__(self) -> str:
        """Provide a human-readable error message."""
        return f"Could not find a solution: {self!r}"
