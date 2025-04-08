#!/usr/bin/env python3


def subsequence(sub, full):
    """ Given two strings, return if one string is a subsequence of another.

    >>> subsequence("uvw", "bcudvew")
    True
    >>> subsequence("aec", "abcde")
    False
    >>> subsequence("sip", "javascript")
    True
    >>> subsequence("", "")
    True
    """
    position = 0
    for character in sub:
        try:
            index = full.index(character, position)
        except ValueError:
            return False
        position = index + 1
    return True


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
