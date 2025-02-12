#!/usr/bin/env python3


def count_common(strings1, strings2):
    """ Given two array of strings, return the count of common strings in both
    arrays.
    >>> count_common(("perl", "weekly", "challenge"), ("raku", "weekly", "challenge"))
    2
    >>> count_common(("perl", "raku", "python"), ("python", "java"))
    1
    >>> count_common(("guest", "contribution"), ("fun", "weekly", "challenge"))
    0
    """
    return len(set(strings1).intersection(strings2))


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
