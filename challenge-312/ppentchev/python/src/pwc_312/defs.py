# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause
"""Common definitions for the pwc-312 module."""

from __future__ import annotations

import typing


if typing.TYPE_CHECKING:
    from typing import Final


"""The pwc-312 version string, semver-like."""
VERSION: Final = "0.1.0"
