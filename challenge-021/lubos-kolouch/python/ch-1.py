#!/usr/bin/env python3
"""
Challenge 021 - Task 1: Calculate Euler's Number

Write a script to calculate the value of e, also known as Euler's number
and Napier's constant.

Euler's number can be calculated using the infinite series:
e = 1/0! + 1/1! + 1/2! + 1/3! + ... = sum(1/n!) for n from 0 to infinity

This is also the limit of (1 + 1/n)^n as n approaches infinity.
"""

import math
from collections.abc import Generator


def factorial(n: int) -> int:
    """
    Calculate the factorial of a non-negative integer.

    Args:
        n: Non-negative integer

    Returns:
        The factorial of n
    """
    if n < 0:
        raise ValueError("Factorial is not defined for negative numbers")
    if n == 0 or n == 1:
        return 1

    result = 1
    for i in range(2, n + 1):
        result *= i
    return result


def calculate_e_iterative(precision: int = 15) -> float:
    """
    Calculate e using the iterative series method.

    e = sum(1/n!) for n from 0 to infinity

    Args:
        precision: Number of decimal places to calculate

    Returns:
        Approximation of e
    """
    e = 0.0
    n = 0

    while True:
        term = 1.0 / factorial(n)
        e += term

        # Stop when the term is smaller than what affects the precision
        if term < 10 ** (-precision):
            break

        n += 1

    return e


def calculate_e_limit(n: int) -> float:
    """
    Calculate e as the limit of (1 + 1/n)^n.

    Args:
        n: The number of iterations (larger n gives better approximation)

    Returns:
        Approximation of e
    """
    return (1 + 1 / n) ** n


def generate_e_series() -> Generator[float, None, None]:
    """
    Generate successive approximations of e using the series expansion.

    Yields:
        Successive approximations of e
    """
    e = 0.0
    n = 0

    while True:
        term = 1.0 / factorial(n)
        e += term
        yield e
        n += 1


def main():
    """Main function to calculate and display e."""
    # Calculate using the iterative method
    e_value = calculate_e_iterative(15)

    # Display results
    print(f"Calculated e (series method): {e_value:.15f}")
    print(f"Python math.e:               {math.e:.15f}")

    # Show convergence
    print("\nConvergence of series method:")
    gen = generate_e_series()
    for i in range(10):
        approx = next(gen)
        print(f"  Iteration {i}: {approx:.10f}")


if __name__ == "__main__":
    main()
