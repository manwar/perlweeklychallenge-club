#!/usr/bin/env python3


def sort_language(lang, popularity):
    ''' Given 2 arrays: languages and popularity. Sorts the language
    based on popularity.
    >>> sort_language(('perl', 'c', 'python'), (2, 1, 3))
    ('c', 'perl', 'python')
    >>> sort_language(('c++', 'haskell', 'java'), (1, 3, 2))
    ('c++', 'java', 'haskell')
    '''
    return tuple(sorted(lang, key=lambda l: popularity[lang.index(l)]))


if __name__ == "__main__":
    import doctest

    doctest.testmod()
