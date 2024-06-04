#!/usr/bin/env python3


def string_score(string):
    ''' Given a, string, return the score of the given string.

        The score of a string is defined as the sum of the absolute difference
        between the ASCII values of adjacent characters.
    >>> string_score('hello')
    13
    >>> string_score('perl')
    30
    >>> string_score('raku')
    37
    >>> string_score('')
    0
    >>> string_score("*")
    0
    '''
    return sum(abs(ord(a) - ord(b)) for a, b in zip(string, string[1:]))


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
