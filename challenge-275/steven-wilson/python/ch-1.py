#!/usr/bin/env python3


def typed_fully(sentence, *keys):
    ''' Given a sentence and list of broken keys, return number of words can be
    typed fully.
    >>> typed_fully("Perl Weekly Challenge", 'l', 'a')
    0
    >>> typed_fully("Perl and Raku", 'a')
    1
    >>> typed_fully("Well done Team PWC", 'l', 'o')
    2
    >>> typed_fully("The joys of polyglottism", 'T')
    2
    '''
    return sum(1 for word in sentence.split() if not any(key.casefold() in word.casefold() for key in keys))


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
