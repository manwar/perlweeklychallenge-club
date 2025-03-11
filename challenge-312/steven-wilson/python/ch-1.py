#!/usr/bin/env python3


def minimum_time(string):
    """ Given a typewriter with lowercase english letters a to z arranged in a
    circle.  Typing a character takes 1 sec. You can move pointer one character
    clockwise or anti-clockwise.  The pointer initially points at a.  Return
    minimum time it takes to print the given string.

    >>> minimum_time("abc")
    5
    >>> minimum_time("bza")
    7
    >>> minimum_time("zjpc")
    34
    """
    pointer = 'a'
    time = 0
    if pointer == string[0]:
        time += 1
        string = string[1:]

    for c in string:
        time += letters_delta(pointer, c)
        pointer = c
        time += 1  # typing takes 1 sec

    return time


def letters_delta(start, end):
    """ Return min time between 2 letters.

    >>> letters_delta('a', 'z')
    1
    >>> letters_delta('a', 'n')
    13
    >>> letters_delta('a', 'b')
    1
    >>> letters_delta('w', 'c')
    6
    """
    delta = abs(ord(start) - ord(end))
    return delta if delta <= 13 else 26 - delta


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
