#!/usr/bin/env python3

from collections import Counter


def odd_character(original, shuffled):
    ''' Given two strings, the second string generated using the shuffled
    characters of the first string with an additional character.  Function
    returns the additional character.
    >>> odd_character("Perl", "Preel")
    'e'
    >>> odd_character("Weekly", "Weeakly")
    'a'
    >>> odd_character("Box", "Boxy")
    'y'
    '''
    if not original or not shuffled:
        raise ValueError("Both strings must be non-empty.")

    original_counter = Counter(original.casefold())
    shuffled_counter = Counter(shuffled.casefold())

    difference_counter = shuffled_counter - original_counter

    if not difference_counter or sum(difference_counter.values()) > 1:
        raise ValueError("No unique additional character found.")

    return next(difference_counter.elements())


if __name__ == "__main__":
    import doctest

    doctest.testmod()
