#!/usr/bin/env python3

from itertools import chain


def merge_strings(first, second):
    ''' Given two strings, merge the given strings by adding in alternative
    order starting with the first string. If a string is longer than the other
    then append the remaining at the end.
    >>> merge_strings("abcd", "1234")
    'a1b2c3d4'
    >>> merge_strings("abc", "12345")
    'a1b2c345'
    >>> merge_strings("abcde", "123")
    'a1b2c3de'
    '''
    return ("".join(chain.from_iterable(zip(first, second))) +
            first[len(second):] +
            second[len(first):])


if __name__ == "__main__":
    import doctest

    doctest.testmod()
