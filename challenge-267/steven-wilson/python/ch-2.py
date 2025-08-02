#!/usr/bin/env python3

from string import ascii_lowercase
LINE_WIDTH = 100


def line_counts(string, *widths):
    ''' Given a string and a 26-items array containing the width of each
    character from a to z, find out the number of lines and the width of the
    last line needed to display the given string, assuming you can only fit 100
    width units on a line.
    >>> line_counts("abcdefghijklmnopqrstuvwxyz",10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10)
    (3, 60)
    >>> line_counts("bbbcccdddaaa",4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10)
    (2, 4)
    '''
    if not all(x in ascii_lowercase for x in string):
        raise TypeError('string should be all ascii lowercase')

    if not all(isinstance(x, int) for x in widths):
        raise TypeError('All widths should be of type int')

    if not len(widths) == 26:
        raise TypeError("Not the corrent amount of arguments, there should be 26 widths")

    widths_count = dict(zip(ascii_lowercase, widths))
    lines = []
    current_line = []
    current_width = 0

    for character in string:
        character_width = widths_count[character]
        if current_width + character_width > LINE_WIDTH:
            lines.append(''.join(current_line))
            current_line = []
            current_width = 0
        current_line.append(character)
        current_width += character_width
    lines.append(''.join(current_line))

    return (len(lines), current_width)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
