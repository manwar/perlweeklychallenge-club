#!/usr/bin/env python3


def word_count(words):
    """ Given a list of words containing alphabetic characters only, return the
    count of words either starting with a vowel or ending with a vowel.

    >>> word_count(["unicode", "xml", "raku", "perl"])
    2
    >>> word_count(["the", "weekly", "challenge"])
    2
    >>> word_count(["perl", "python", "postgres"])
    0
    """
    vowels = {'a', 'e', 'i', 'o', 'u'}
    return sum(1 for w in words
               if (c := w.casefold())[0] in vowels or c[-1] in vowels)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
