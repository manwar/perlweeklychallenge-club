#!/usr/bin/env python3


def reverse_letters(string):
    """ Given a string, reverse only the alphabetic characters in the string.

    >>> reverse_letters('p-er?l')
    'l-re?p'
    >>> reverse_letters('wee-k!L-y')
    'yLk-e!e-w'
    >>> reverse_letters('_c-!h_all-en!g_e')
    '_e-!g_nel-la!h_c'
    """
    alpha_reversed = reversed([c for c in string if c.isalpha()])
    return "".join(next(alpha_reversed) if c.isalpha() else c for c in string)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
