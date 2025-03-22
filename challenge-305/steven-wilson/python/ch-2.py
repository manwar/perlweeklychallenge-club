#!/usr/bin/env python3


def alien_dictionary(words, alien):
    """ Given a list of words and alien dictionary character order, sort
    lexicographically the given list of words based on the alien dictionary
    characters.

    >>> a = ('h', 'l', 'a', 'b', 'y', 'd', 'e', 'f', 'g', 'i', 'r', 'k', 'm', \
'n', 'o', 'p', 'q', 'j', 's', 't', 'u', 'v', 'w', 'x', 'c', 'z')
    >>> alien_dictionary(("perl", "python", "raku"), a)
    ('raku', 'python', 'perl')
    >>> b = ('c', 'o', 'r', 'l', 'd', 'a', 'b', 't', 'e', 'f', 'g', 'h', 'i', \
'j', 'k', 'm', 'n', 'p', 'q', 's', 'w', 'u', 'v', 'x', 'y', 'z')
    >>> alien_dictionary(("the", "weekly", "challenge"), b)
    ('challenge', 'the', 'weekly')
    """
    dictionary = {c: n for n, c in enumerate(alien)}
    return tuple(sorted(words, key=lambda word:
                 [dictionary.get(c, float('inf')) for c in word.casefold()]))


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
