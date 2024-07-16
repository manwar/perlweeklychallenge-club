#!/usr/bin/env python3

import re
from operator import itemgetter


def sort_string(string):
    """ Given a shuffle string, return the sorted string.  A string is shuffled
    by appending word position to each word.

    >>> sort_string("and2 Raku3 cousins5 Perl1 are4")
    'Perl and Raku are cousins'
    >>> sort_string("guest6 Python1 most4 the3 popular5 is2 language7")
    'Python is the most popular guest language'
    >>> sort_string("Challenge3 The1 Weekly2")
    'The Weekly Challenge'
    """
    p = re.compile('^(\w+)(\d+)$')
    words_numbers = (p.search(word).groups() for word in string.split(" "))
    words_numbers_sorted = sorted(((w[0], int(w[1])) for w in words_numbers), key=itemgetter(1))
    return " ".join(word[0] for word in words_numbers_sorted)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
