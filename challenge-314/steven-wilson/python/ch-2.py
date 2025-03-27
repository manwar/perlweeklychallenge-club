#!/usr/bin/env python3


def sort_columns(*strings):
    """ Given a list of strings of same length, make each column sorted
    lexicographically by deleting any non sorted columns, return the total
    columns deleted.

    >>> sort_columns("swpc", "tyad", "azbe")
    2
    >>> sort_columns("cba", "daf", "ghi")
    1
    >>> sort_columns("a", "b", "c")
    0
    """
    return sum(1 for c in zip(*strings) if sorted(c) != list(c))


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
