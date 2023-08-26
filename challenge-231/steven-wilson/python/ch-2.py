#!/usr/bin/env python3

import re


def senior_citizen(elements):
    """Return count of passanges age >= 60 from passanger details
    >>> senior_citizen( ["7868190130M7522","5303914400F9211","9273338290F4010"] )
    2
    >>> senior_citizen( ["1313579440F2036","2921522980M5644"] )
    0
    """
    seniors = 0
    for elem in elements:
        match = re.search(r"(\d{2})\d{2}$", elem)
        if int(match.group(1)) >= 60:
            seniors += 1
    return seniors


if __name__ == "__main__":
    import doctest

    doctest.testmod()
