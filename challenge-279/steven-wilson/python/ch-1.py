#!/usr/bin/env python3


def sort_letters(letters, weights):
    """ Given two arrays, sort the given array letters based on the weights.
    >>> sort_letters(('R', 'E', 'P', 'L'), (3, 2, 1, 4))
    'PERL'
    >>> sort_letters(('A', 'U', 'R', 'K'), (2, 4, 1, 3))
    'RAKU'
    >>> sort_letters(('O', 'H', 'Y', 'N', 'P', 'T'), (5, 4, 2, 6, 1, 3))
    'PYTHON'
    """
    letters_sorted = (l for _, l in sorted(zip(weights, letters)))
    return "".join(letters_sorted)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
