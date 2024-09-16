# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause
"""Basic test for file importing."""

from __future__ import annotations

import typing

from packaging import version as pkg_version

from perl_weekly_285 import defs


if typing.TYPE_CHECKING:
    from typing import Final


def test_version() -> None:
    """Make sure the `VERSION` variable has a sane value."""
    version: Final = pkg_version.Version(defs.VERSION)
    assert version > pkg_version.Version("0")
