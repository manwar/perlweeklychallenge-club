#!/usr/bin/env python3

from more_itertools import windowed


def circular(*words):
    """ Given a list of words, return whether the last character of each word
    is the first character of the following word.

    >>> circular("perl", "loves", "scala")
    True
    >>> circular("love", "the", "programming")
    False
    >>> circular("java", "awk", "kotlin", "node.js")
    True
    >>> circular()
    True
    >>> circular("a")
    True
    """
    if len(words) < 2:
        return True
    return all(word[-1] == following[0] for word, following in windowed(words, 2))


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
