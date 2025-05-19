#!/usr/bin/env python3

from more_itertools import chunked


def string_format(string, size):
    """ Given a string and a positive integer, format the string, removing any
    dashes, in groups of size given by the integer. The first group can be
    smaller than the integer but should have at least one character. Groups
    should be separated by dashes.

    >>> string_format("ABC-D-E-F", 3)
    'ABC-DEF'
    >>> string_format("A-BC-D-E", 2)
    'A-BC-DE'
    >>> string_format("-A-B-CD-E", 4)
    'A-BCDE'
    """
    characters = [c for c in reversed(string) if c.isalpha()]
    chunks = chunked(characters, size)
    grouped = ["".join(a) for a in chunks]
    return "-".join(grouped)[::-1]


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
