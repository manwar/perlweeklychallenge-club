# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause
"""Test the first task in Perl weekly challenge 285, "No Connection"."""

from __future__ import annotations

import dataclasses

import pytest

from perl_weekly_285 import defs
from perl_weekly_285 import routes


@dataclasses.dataclass(frozen=True)
class RoutesCase:
    """A test case for the "No Connection" task."""

    routes: list[tuple[str, str]]
    """The routes to examine."""

    expected: str
    """The leaf destination we expect to find."""


@pytest.mark.parametrize(
    "tcase",
    [
        RoutesCase(
            routes=[
                ("me", "you"),
            ],
            expected="you",
        ),
        RoutesCase(
            routes=[
                ("here", "there"),
                ("here", "everywhere"),
                ("there", "everywhere"),
            ],
            expected="everywhere",
        ),
        RoutesCase(
            routes=[("B", "C"), ("D", "B"), ("C", "A")],
            expected="A",
        ),
    ],
)
def test_connection(*, tcase: RoutesCase) -> None:
    """Make sure we can find the leaf destination."""
    assert routes.solve_no_connection(tcase.routes) == tcase.expected


@pytest.mark.parametrize(
    "tcase",
    [
        RoutesCase(
            routes=[
                ("here", "there"),
                ("here", "everywhere"),
            ],
            expected="not really",
        ),
        RoutesCase(
            routes=[("me", "you"), ("you", "me")],
            expected="not really",
        ),
    ],
)
def test_no_connection(*, tcase: RoutesCase) -> None:
    """Make sure we cannot find any leaf destination."""
    with pytest.raises(defs.NoSolutionError):
        routes.solve_no_connection(tcase.routes)
