#!/usr/bin/env python3


def zero_friend(numbers):
    """ Given a list of numbers, find the number that is closest to zero and
    return its distance to zero.

    >>> zero_friend([4, 2, -1, 3, -2])
    1
    >>> zero_friend([-5, 5, -3, 3, -1, 1])
    1
    >>> zero_friend([7, -3, 0, 2, -8])
    0
    >>> zero_friend([-2, -5, -1, -8])
    1
    >>> zero_friend([-2, 2, -4, 4, -1, 1])
    1
    """
    return min(abs(x) for x in numbers)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
