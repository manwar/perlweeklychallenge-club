#!/usr/bin/env python3
"""Gamma Function - Perl Weekly Challenge 167 task 2.

Implements the gamma function using the Lanczos approximation.
"""

from __future__ import annotations

from collections.abc import Sequence
import math
import sys
import unittest


def gamma_lanczos(z: float) -> float:
    """Return an approximation of Γ(z) using Lanczos approximation."""
    if z <= 0:
        raise ValueError("Expected a positive number")

    # Coefficients from Wikipedia (g=7, n=9).
    g = 7
    p = (
        0.99999999999980993,
        676.5203681218851,
        -1259.1392167224028,
        771.3234287776531,
        -176.6150291621406,
        12.507343278686905,
        -0.13857109526572012,
        9.984369578019572e-6,
        1.5056327351493116e-7,
    )

    if z < 0.5:
        return math.pi / (math.sin(math.pi * z) * gamma_lanczos(1 - z))

    x = p[0]
    for i in range(1, len(p)):
        x += p[i] / (z + i - 1)

    t = z + g - 0.5
    return math.sqrt(2 * math.pi) * (t ** (z - 0.5)) * math.exp(-t) * x


class GammaLanczosExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertLessEqual(abs(gamma_lanczos(3) - 1.99), 0.02)

    def test_example_2(self) -> None:
        self.assertLessEqual(abs(gamma_lanczos(5) - 24), 0.02)

    def test_example_3(self) -> None:
        self.assertLessEqual(abs(gamma_lanczos(7) - 719.99), 0.02)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-2.py <z>")
    z = float(args[0])
    print(gamma_lanczos(z))


if __name__ == "__main__":
    main()

