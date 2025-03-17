#!/usr/bin/env python3

from itertools import groupby, zip_longest


def broken_keys(name, typed):
    """ You have a broken keyboard which sometimes type a character more than
    once.  You are given a string and actual typed string, find out if the
    actual typed string is meant for the given string.

    >>> broken_keys("perl", "perrrl")
    True
    >>> broken_keys("raku", "rrakuuuu")
    True
    >>> broken_keys("python", "perl")
    False
    >>> broken_keys("coffeescript", "cofffeescccript")
    True
    >>> broken_keys("", "")
    True
    >>> broken_keys("haskell", "")
    False
    """
    name_cc = character_counts(name)
    typed_cc = character_counts(typed)

    return all(nc == tc and ns <= ts for (nc, ns), (tc, ts) in
               zip_longest(name_cc, typed_cc, fillvalue=(None, 0)))


def character_counts(string):
    """ Return pairs of characters and counts of grouped characters."""
    return ((c, sum(1 for _ in g)) for c, g in groupby(string))


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
