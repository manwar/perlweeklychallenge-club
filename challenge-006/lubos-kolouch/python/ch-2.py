#!/usr/bin/env python3
"""Perl Weekly Challenge 006 - Task 2: Ramanujan's constant.

Calculate Ramanujan's constant e^(pi * sqrt(163)) with at least 32 digits of precision.
"""

from __future__ import annotations

from decimal import Decimal, getcontext
import unittest


def pi(prec: int) -> Decimal:
    """Calculate pi to the given precision using Machin's formula.

    :param prec: Number of significant digits.
    :return: Decimal representation of pi.
    """
    getcontext().prec = prec + 10

    def arctan(x: Decimal, num_terms: int = 200) -> Decimal:
        power = x
        result = x
        for n in range(1, num_terms):
            power *= -x * x
            result += power / (2 * n + 1)
        return result

    pi_val = 4 * (4 * arctan(Decimal(1) / 5) - arctan(Decimal(1) / 239))
    getcontext().prec = prec
    return +pi_val


def exp_value(x: Decimal, prec: int) -> Decimal:
    """Calculate e^x using the Taylor series expansion.

    :param x: Decimal exponent.
    :param prec: Number of significant digits.
    :return: e^x as Decimal.
    """
    getcontext().prec = prec + 10
    result = Decimal(1)
    term = Decimal(1)
    for i in range(1, 500):
        term *= x / i
        result += term
        if abs(term) < Decimal(10) ** (-(prec + 5)):
            break
    getcontext().prec = prec
    return +result


def ramanujan_constant(prec: int = 35) -> str:
    """Calculate Ramanujan's constant: e^(pi * sqrt(163)).

    :param prec: Precision digits.
    :return: String representation of Ramanujan's constant to requested precision.
    """
    getcontext().prec = prec + 10

    pi_val = pi(prec + 10)
    sqrt_163 = Decimal(163).sqrt()
    exponent = pi_val * sqrt_163

    getcontext().prec = prec
    result = exp_value(exponent, prec)
    return str(result)


class TestRamanujanConstant(unittest.TestCase):
    """Test cases for ramanujan_constant."""

    def test_precision(self) -> None:
        res = ramanujan_constant(35)
        # Expected value begins with:
        # 262537412640768743.99999999999925...
        self.assertTrue(
            res.startswith("262537412640768743.99999999999925"),
            f"Result {res} did not match expected prefix",
        )


if __name__ == "__main__":
    unittest.main()
