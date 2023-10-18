#!/usr/bin/env python3


def consistent_strings(allowed, strings):
    ''' return the number of consistent strings in the given array
    >>> consistent_strings("ab", ("ad", "bd", "aaab", "baa", "badab"))
    2
    >>> consistent_strings("abc", ("a", "b", "c", "ab", "ac", "bc", "abc"))
    7
    >>> consistent_strings("cad", ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d"))
    4
    '''
    count = 0
    for string in strings:
        if set(string).issubset(allowed):
            count += 1
    return count


if __name__ == "__main__":
    import doctest

    doctest.testmod()
