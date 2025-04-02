#!/usr/bin/env python3


def find_word(*words, char):
    """ Given a list of words and a character, return the index of word in the
    list where you find the given character.

    >>> find_word("the", "weekly", "challenge", char="e")
    (0, 1, 2)
    >>> find_word("perl", "raku", "python", char="p")
    (0, 2)
    >>> find_word("abc", "def", "bbb", "bcd", char="b")
    (0, 2, 3)
    """
    return tuple(n for n, w in enumerate(words) if char in w)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
