#!/usr/bin/env python

"""
Challenge 006 - Task 2

Create a script to calculate Ramanujan's constant with at least 32 digits of
precision.

Ramanujan's constant is e^(pi * sqrt(163)), which produces a value remarkably
close to an integer.

The standard IEEE 754 double-precision binary floating-point format: binary64
gives only 15 to 17 significant decimal digits. Therefore the decimal module
must be used for high-precision arithmetic.
"""

from decimal import Decimal, getcontext


def pi(prec):
    """Calculate pi to the given precision using the Chudnovsky algorithm.

    Args:
        prec (int): Number of significant digits.

    Returns:
        Decimal: Pi calculated to the requested precision.
    """
    getcontext().prec = prec + 10  # extra guard digits

    # Machin's formula: pi = 4 * (4*arctan(1/5) - arctan(1/239))
    def arctan(x, num_terms=200):
        power = x
        result = x
        for n in range(1, num_terms):
            power *= -x * x
            result += power / (2 * n + 1)
        return result

    pi_val = 4 * (4 * arctan(Decimal(1) / 5) - arctan(Decimal(1) / 239))
    getcontext().prec = prec + 2  # restore with minimal guard
    return +pi_val


def exp_value(x, prec):
    """Calculate e^x using the Taylor series.

    Args:
        x (Decimal): The exponent.
        prec (int): Number of significant digits.

    Returns:
        Decimal: e raised to the power x.
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


def ramanujan_constant(prec=50):
    """Calculate Ramanujan's constant: e^(pi * sqrt(163)).

    Args:
        prec (int): Number of significant digits (default 50).

    Returns:
        Decimal: Ramanujan's constant.
    """
    getcontext().prec = prec + 10

    pi_val = pi(prec + 10)
    sqrt_163 = Decimal(163).sqrt()
    exponent = pi_val * sqrt_163

    getcontext().prec = prec
    result = exp_value(exponent, prec)
    return result


if __name__ == "__main__":
    # Get the first 31 digits (30 after the dot plus the leading digit)
    # Ramanujan's constant ~= 262537412640768743.999999999999250072...
    result = ramanujan_constant(prec=35)
    print(result)
