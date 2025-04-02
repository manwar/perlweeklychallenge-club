#!/usr/bin/env python3

import re


def find_third(sentence, first, second):
    """ Given a sentence and two words, return all words in the given
    sentence that appear in sequence to the given two words.

    >>> find_third("Perl is a my favourite language but Python is my favourite too.", "my", "favourite")
    ('language', 'too')
    >>> find_third("Barbie is a beautiful doll also also a beautiful princess.", "a", "beautiful")
    ('doll', 'princess')
    >>> find_third("we will we will rock you rock you.", "we", "will")
    ('we', 'rock')
    """
    pattern = re.compile(rf'(?={first}\s+{second}\s+(\w+))')
    return tuple(match.group(1) for match in pattern.finditer(sentence))


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
