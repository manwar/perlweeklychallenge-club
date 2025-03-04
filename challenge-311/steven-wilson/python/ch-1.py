#!/usr/bin/env python3


def upper_lower(string):
    """ Given a string consists of english letters only, convert lower case to
    upper and upper case to lower in the given string.

    >>> upper_lower("pERl")
    'PerL'
    >>> upper_lower("rakU")
    'RAKu'
    >>> upper_lower("PyThOn")
    'pYtHoN'
    """
    return ''.join(c.lower() if c.isupper() else c.upper() for c in string)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
