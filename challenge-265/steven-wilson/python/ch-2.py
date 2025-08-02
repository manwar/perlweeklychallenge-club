#!/usr/bin/env python3

from collections import Counter


def completing_word(string, words):
    ''' Given a string containing alphnumeric characters and array of strings
    (alphabetic characters only), find the shortest completing word. If none
    found return empty string.

        A completing word is a word that contains all the letters in the given
        string, ignoring space and number. If a letter appeared more than once
        in the given string then it must appear the same number or more in the
        word.
    >>> completing_word('aBc 11c', ('accbbb', 'abc', 'abbc'))
    'accbbb'
    >>> completing_word('Da2 abc', ('abcm', 'baacd', 'abaadc'))
    'baacd'
    >>> completing_word('JB 007', ('jj', 'bb', 'bjb'))
    'bjb'
    '''
    counter = Counter(c.lower() for c in string if c.isalpha())

    completing = (word for word in words if all(v <= word.count(c) for c, v in counter.items()))

    return min(completing, key=len, default='')


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
