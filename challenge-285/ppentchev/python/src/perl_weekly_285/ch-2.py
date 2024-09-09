# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause
"""Solve the second task in Perl weekly challenge 285, "Making Change"."""

from __future__ import annotations

import enum
import itertools
import typing


if typing.TYPE_CHECKING:
    from typing import Final


class Coin(enum.IntEnum):
    """A single denomination for breaking change down."""

    PENNY = 1
    NICKEL = 5
    DIME = 10
    QUARTER = 25
    HALF_DOLLAR = 50

    def lower(self) -> Coin:
        """Return the next lower denomination."""
        match self:
            case value if value == Coin.PENNY:
                raise RuntimeError(repr(self))

            case value if value == Coin.NICKEL:
                return Coin.PENNY

            case value if value == Coin.DIME:
                return Coin.NICKEL

            case value if value == Coin.QUARTER:
                return Coin.DIME

            case value if value == Coin.HALF_DOLLAR:
                return Coin.QUARTER


_ORDER_ABP: Final = [Coin.HALF_DOLLAR, Coin.QUARTER, Coin.DIME, Coin.NICKEL]
"""The denominations in descending order."""


def break_down_ways(amount: int, highest: Coin) -> list[tuple[int, Coin]]:
    """Make sure of things and stuff."""

    def process_single(high: Coin) -> list[tuple[int, Coin]]:
        """Get the candidates if we use this coin."""
        lower: Final = high.lower()
        return [(amount - mult, lower) for mult in range(high, amount + 1, high)]

    return list(itertools.chain(*(process_single(high) for high in _ORDER_ABP if high <= highest)))


def make_change_rec(amount: int, highest: Coin, cache: dict[tuple[int, Coin], int]) -> int:
    """Let me count the ways, recursively."""

    def trivial(amt: int, high: Coin) -> bool:
        """Sometimes there is only one."""
        return amt == 0 or high == Coin.PENNY

    if trivial(amount, highest):
        return 1

    cached: Final = cache.get((amount, highest))
    if cached is not None:
        return cached

    def process_single(amt: int, high: Coin) -> int:
        """Recursively count fewer ways."""
        if trivial(amt, high):
            return 1

        return make_change_rec(amt, high, cache)

    ways: Final = break_down_ways(amount, highest)
    total: Final = 1 + sum(itertools.starmap(process_single, ways))
    cache[amount, highest] = total
    return total


def solve_making_change(amount: int) -> int:
    """Let me count the ways."""
    return make_change_rec(amount, Coin.HALF_DOLLAR, {})
