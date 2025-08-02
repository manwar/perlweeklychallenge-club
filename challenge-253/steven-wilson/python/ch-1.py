#!/usr/bin/env python3


def split_strings(*strings, separator=","):
    ''' Given an array of strings and a character separator.
    Return all words separated by the given character excluding empty strings
    >>> split_strings("one.two.three","four.five","six", separator=".")
    ['one', 'two', 'three', 'four', 'five', 'six']
    >>> split_strings("$perl$$", "$$raku$", separator="$")
    ['perl', 'raku']
    '''
    return [word for string in strings for word in string.split(separator) if word != ""]


if __name__ == "__main__":
    import doctest

    doctest.testmod()
