#!/usr/bin/env python3


VOWELS = set('aeiou')


def reverse_vowels(string):
    ''' Given a string reverse all the vowels (a, e, i, o, u) and return
    resulting string.

    >>> reverse_vowels('Raku')
    'Ruka'
    >>> reverse_vowels('Perl')
    'Perl'
    >>> reverse_vowels('Julia')
    'Jaliu'
    >>> reverse_vowels('Uiua')
    'Auiu'
    '''
    string = string.lower()
    indexes = []
    cs = []
    for index, c in enumerate(string):
        if c in VOWELS:
            indexes.append(index)
            cs.append(c)

    if len(indexes) < 2:
        return string.title()
    else:
        characters = list(string)
        for index in indexes:
            characters[index] = cs.pop()
        return ''.join(characters).title()


if __name__ == "__main__":
    import doctest

    doctest.testmod()
