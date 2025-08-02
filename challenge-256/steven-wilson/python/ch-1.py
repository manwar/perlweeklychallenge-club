#!/usr/bin/env python3


def maximum_pairs(*words):
    ''' Given an array of distinct words.  Find the maximum pairs in the given
    array. The words $words[i] and $words[j] can be a pair one is reverse of
    the other.
    >>> maximum_pairs("ab", "de", "ed", "bc")
    1
    >>> maximum_pairs("aa", "ba", "cd", "ed")
    0
    >>> maximum_pairs("uv", "qp", "st", "vu", "mn", "pq")
    2
    '''

    words_set = set(words)
    if not len(words) == len(words_set):
        raise AssertionError("Array of words were not distinct")

    sum_pairs = sum(1 for word in words if word[::-1] in words_set)
    return int(sum_pairs/2)


if __name__ == "__main__":
    import doctest

    doctest.testmod()
