#!/usr/bin/env python3


def increment_decrement(operations):
    """ Given a list of operations, return the final value after performing the
    given operations in order. The initial value is always 0.

    >>> increment_decrement(["--x", "x++", "x++"])
    1
    >>> increment_decrement(["x++", "++x", "x++"])
    3
    >>> increment_decrement(["x++", "++x", "--x", "x--"])
    0
    """
    increment = {"++x", "x++"}
    decrement = {"--x", "x--"}
    value = 0
    for op in operations:
        if op in increment:
            value += 1
        elif op in decrement:
            value -= 1
    return value


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
