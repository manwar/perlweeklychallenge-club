#!/usr/bin/env python


def unique_sum_zero(n: int) -> list:
    """
    Generates a list of `n` unique integers that sum to zero.

    Parameters:
    n (int): The size of the list.

    Returns:
    list: A list of `n` unique integers that add up to zero.
    """
    # For even n, use symmetric pairs; for odd n, include 0 and symmetric pairs
    return (
        [i for i in range(1, n // 2 + 1)]
        + [-i for i in range(1, n // 2 + 1)]
        + ([0] if n % 2 != 0 else [])
    )


# Tests
assert sum(unique_sum_zero(5)) == 0
assert sum(unique_sum_zero(3)) == 0
assert sum(unique_sum_zero(1)) == 0
