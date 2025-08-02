#!/usr/bin/env python3

from collections import Counter


def greatest_english_letter(string):
    ''' Given a string made up of only alphabetic characters [a..zA..Z], return
    the greatest english letter in the given string.  A letter is greatest if
    it occurs as lower and upper case. Also letter ‘b’ is greater than ‘a’ if
    ‘b’ appears after ‘a’ in the English alphabet.
    >>> greatest_english_letter('PeRlwEeKLy')
    'L'
    >>> greatest_english_letter('ChaLlenge')
    'L'
    >>> greatest_english_letter('The')
    ''
    '''
    if not string.isalpha():
        raise ValueError("All characters in string must be in alphabet")

    counter = Counter(string)
    greatest = [c for c in counter.keys() if c.islower() and c.upper() in counter]
    return max(greatest, default='').upper()


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
