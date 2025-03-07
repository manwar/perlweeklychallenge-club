#!/usr/bin/env python3


def last_element(*integers):
    """ Given a array of integers, play a game where you pick two biggest
    integers in the given array, say x and y. Then do the following:

        a) if x == y then remove both from the given array
        b) if x != y then remove x and replace y with (y - x)

    At the end of the game, there is at most one element left.

    Return the last element if found otherwise return 0.

    >>> last_element(3, 8, 5, 2, 9, 2)
    1
    >>> last_element(3, 2, 5)
    0
    """
    integers = sorted(integers)
    while len(integers) > 1:
        x, y = integers[-2:]
        if x == y:
            integers = integers[:-2]
        else:
            integers = integers[:-2]
            integers.append(y - x)
            integers = sorted(integers)
    return 0 if len(integers) == 0 else integers[0]


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
