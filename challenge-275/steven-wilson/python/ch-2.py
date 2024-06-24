#!/usr/bin/env python3


def replace_digits(string):
    ''' Given an alphanumeric string, where each character is either a letter
    or a digit, replace each digit in the given string with the value of the
    previous letter plus (digit) places.
    >>> replace_digits('a1c1e1')
    'abcdef'
    >>> replace_digits('a1b2c3d4')
    'abbdcfdh'
    >>> replace_digits('b2b')
    'bdb'
    >>> replace_digits('a16z')
    'abgz'
    '''
    if not string[0].isalpha():
        raise ValueError('First character of string should be letter.')

    if not string.isalnum():
        raise ValueError('String should be alphanumeric')

    previous_letter = None
    result = []
    for c in string:
        if c.isdigit():
            result.append(chr(ord(previous_letter) + int(c)))
        else:
            result.append(c)
            previous_letter = c
    return "".join(result)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
