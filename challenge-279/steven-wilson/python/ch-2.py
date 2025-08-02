#!/usr/bin/env python3

from pprint import pprint


def split_string(string, print_strings=False):
    """ Given a string, split the given string into two containing exactly same
    number of vowels and return true if you can otherwise false.
    >>> split_string("perl")
    False
    >>> split_string("book")
    True
    >>> split_string("good morning")
    True
    """
    if len(string) < 2:
        return False

    position_vowels = [i for i, c in enumerate(string) if c.casefold() in 'aeiou']

    if not len(position_vowels) % 2 == 0:
        return False

    if print_strings:
        if len(position_vowels) < 2:
            (start, stop) = (0, len(string)-1)
        else:
            split_index = int(len(position_vowels)/2) - 1
            (start, stop) = (position_vowels[split_index], position_vowels[split_index+1])
        pprint([(string[:i+1], string[i+1:]) for i in range(start, stop)])

    return True


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
