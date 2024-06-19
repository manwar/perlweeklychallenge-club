#!/usr/bin/env python3

import math


def percentage_of_character(string, character):
    ''' Given a string and a character, return the percentage, nearest whole,
    of given character in the given string.
    >>> percentage_of_character("perl", "e")
    25
    >>> percentage_of_character("java", "a")
    50
    >>> percentage_of_character("python", "m")
    0
    >>> percentage_of_character("ada", "a")
    67
    >>> percentage_of_character("ballerina", "l")
    22
    >>> percentage_of_character("analitik", "k")
    13
    '''
    return math.floor((string.count(character) / len(string) * 100) + 0.5)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
