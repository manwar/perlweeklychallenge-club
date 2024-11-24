#!/usr/bin/env python3

from itertools import groupby


def string_compression(string):
    """ Given a string of alphabetic characters. Compress the string with
    run-length encoding.  A compressed unit can be either a single character or
    a count followed by a character.

    >>> string_compression("abbc")
    'a2bc'
    >>> string_compression("aaabccc")
    '3ab3c'
    >>> string_compression("abcc")
    'ab2c'
    >>> string_compression("")
    ''
    >>> string_compression("ffffffffff")
    '10f'
    """
    if not all(c.isalpha() for c in string):
        raise ValueError("String should only contain alphabetic characters")

    result = []
    for c, g in groupby(string):
        length = sum(1 for _ in g)

        if length == 1:
            result.append(c)
        else:
            result.append(f"{length}{c}")
    return "".join(result)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
