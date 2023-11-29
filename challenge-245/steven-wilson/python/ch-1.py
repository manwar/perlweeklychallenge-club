#!/usr/bin/env python3


def sort_language(language, popularity):
    ''' Given 2 arrays: languages and popularity. Sorts the language
    based on popularity.
    >>> sort_language(('perl', 'c', 'python'), (2, 1, 3))
    ('c', 'perl', 'python')
    >>> sort_language(('c++', 'haskell', 'java'), (1, 3, 2))
    ('c++', 'java', 'haskell')
    '''
    if len(language) != len(popularity):
        raise ValueError("Lengths of 'language' and 'popularity' must be the same.")
    language_popularity = dict(zip(language, popularity))
    return tuple(sorted(language, key=lambda l: language_popularity.get(l)))


if __name__ == "__main__":
    import doctest

    doctest.testmod()
