#!/usr/bin/env python3
"""Wheatstone-Playfair - Perl Weekly Challenge 162 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import re
import string
import sys
import unittest


NON_ALPHA = re.compile(r"[^a-z]+")


def _strip(text: str) -> str:
    out = NON_ALPHA.sub("", text.lower())
    return out.replace("j", "i")


def _posmod(a: int, b: int) -> int:
    m = a % b
    while m < 0:
        m += b
    return m


def _build_square(keyword: str) -> tuple[list[list[str]], dict[str, tuple[int, int]]]:
    kw = ""
    seen: set[str] = set()
    for c in _strip(keyword + string.ascii_lowercase):
        if c == "j":
            c = "i"
        if c not in seen:
            kw += c
            seen.add(c)
    grid: list[list[str]] = []
    pos: dict[str, tuple[int, int]] = {}
    idx = 0
    for r in range(5):
        row: list[str] = []
        for c in range(5):
            ch = kw[idx]
            idx += 1
            row.append(ch)
            pos[ch] = (r, c)
        grid.append(row)
    return grid, pos


def _playfair(direction: int, keyword: str, text: str) -> str:
    grid, pos = _build_square(keyword)
    ii = _strip(text)
    out: list[str] = []
    i = 0
    while i < len(ii):
        a = ii[i]
        b = ii[i + 1] if i + 1 < len(ii) else "x"
        i += 2
        if a == b:
            b = "x"
            i -= 1

        ar, ac = pos[a]
        br, bc = pos[b]
        oar, oac, obr, obc = ar, ac, br, bc

        if ar == br:
            oac = _posmod(ac + direction, 5)
            obc = _posmod(bc + direction, 5)
        elif ac == bc:
            oar = _posmod(ar + direction, 5)
            obr = _posmod(br + direction, 5)
        else:
            oac = bc
            obc = ac

        out.append(grid[oar][oac])
        out.append(grid[obr][obc])

    return "".join(out)


def encrypt(keyword: str, plaintext: str) -> str:
    """Encrypt plaintext using Playfair cipher."""
    return _playfair(1, keyword, plaintext)


def decrypt(keyword: str, ciphertext: str) -> str:
    """Decrypt ciphertext using Playfair cipher."""
    return _playfair(-1, keyword, ciphertext)


class PlayfairExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_encrypt(self) -> None:
        self.assertEqual(
            encrypt("playfair example", "hide the gold in the tree stump"),
            "bmodzbxdnabekudmuixmmouvif",
        )

    def test_decrypt(self) -> None:
        self.assertEqual(
            decrypt("perl and raku", "siderwrdulfipaarkcrw"),
            "thewexeklychallengex",
        )


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit("Usage: python3 ch-2.py  # run tests (spec only)")


if __name__ == "__main__":
    main()

