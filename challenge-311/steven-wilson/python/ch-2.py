#!/usr/bin/env python3

import re


def group_digit_sum(digits, integer):
    """ Given a string made up of digits and an integer which is less than the
    length of the given string, divide the given string into consecutive groups
    of size $int (plus one for leftovers if any). Then sum the digits of each
    group, and concatenate all group sums to create a new string. If the length
    of the new string is less than or equal to the given integer then return
    the new string, otherwise continue the process.

    >>> group_digit_sum("111122333", 3)
    '359'
    >>> group_digit_sum("1222312", 2)
    '76'
    >>> group_digit_sum("100012121001", 4)
    '162'
    """
    while (len(digits) > integer):
        digits = "".join(sum_group(g) for g in
                         re.findall(rf"(\d{{1,{integer}}})", digits))
    return digits


def sum_group(digits):
    '''
    >>> sum_group("123")
    '6'
    '''
    return str(sum(int(d) for d in digits))


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
