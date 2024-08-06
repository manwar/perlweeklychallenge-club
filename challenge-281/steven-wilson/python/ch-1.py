#!/usr/bin/env python3


def check_colour(coordinates):
    """ Given coordinates, a string that represents the coordinates of a square
    of the chessboard return true if the square is light, and false if the
    square is dark
    >>> check_colour("d3")
    True
    >>> check_colour("g5")
    False
    >>> check_colour("e6")
    True
    """
    return not (ord(coordinates[0]) + int(coordinates[1])) % 2 == 0


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
