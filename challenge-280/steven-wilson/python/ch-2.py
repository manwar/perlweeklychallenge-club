#!/usr/bin/env python3


def count_asterisks(string):
    """ Given a string, where every two consecutive vertical bars are grouped
    into a pair, return the number of asterisks, *, excluding any between each
    pair of vertical bars.

    >>> count_asterisks("p|*e*rl|w**e|*ekly|")
    2
    >>> count_asterisks("perl")
    0
    >>> count_asterisks("th|ewe|e**|k|l***ych|alleng|e")
    5
    """
    between = False
    asterisks = 0
    for c in string:
        if c == "|":
            between = not between
        if not between and c == "*":
            asterisks += 1
    return asterisks


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
