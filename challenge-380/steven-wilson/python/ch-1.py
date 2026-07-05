#!/usr/bin/env python3

from collections import Counter

vowels = set("aeiou")


def sof(s):
    """ Given a string consisting of English letters, find the vowel and consonant 
    with maximum frequency. Return the sum of two frequencies.
    >>> sof('banana')
    5
    >>> sof('teestett')
    7
    >>> sof('aeiouuaa')
    3
    >>> sof('rhythm')
    2
    >>> sof('x')
    1
    >>> sof('')
    0
    """
    c = Counter(s)
    v_counts = [n for l, n in c.items() if l in vowels]
    c_counts = [n for l, n in c.items() if l not in vowels]
    return max(v_counts, default=0) + max(c_counts, default=0)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
