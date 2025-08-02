#!/usr/bin/env python3


def tax_amount(income, tax):
    """Given an income amount and tax brackets, calculate the total tax amount.

    >>> tax_amount(10, [[3, 50], [7, 10], [12,25]])
    2.65
    >>> tax_amount(2, [[1, 0], [4, 25], [5,50]])
    0.25
    >>> tax_amount(0, [[2, 50]])
    0
    """
    lower = 0
    bracket_amount = []
    for t in tax:
        if income >= t[0]:
            bracket_amount.append(t[0] - lower)
        elif income > lower:
            bracket_amount.append(income - lower)
        else:
            break
        lower = t[0]
    return sum(amount * (percent[1] / 100) for amount, percent in zip(bracket_amount, tax))


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
