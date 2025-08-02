#!/usr/bin/env python3

from itertools import groupby


def group_position(string):
    """ Given a string of lowercase letters, find the position of all groups in
    the given string. Three or more consecutive letters form a group. Return "”
    if none found.

    >>> group_position("abccccd")
    ('cccc',)
    >>> group_position("aaabcddddeefff")
    ('aaa', 'dddd', 'fff')
    >>> group_position("abcdd")
    ()
    """
    return tuple("".join(g) for g in (list(g) for _, g in
                 groupby(string, key=None)) if len(g) >= 3)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
