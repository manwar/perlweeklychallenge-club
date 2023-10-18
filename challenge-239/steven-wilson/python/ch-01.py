#!/usr/bin/env python3


def same_string(first, second):
    '''
    Is the word created by concatenating the array elements the same
    >>> same_string(["ab", "c"], ["a", "bc"])
    True
    >>> same_string(["ab", "c"], ["ac", "b"])
    False
    >>> same_string(["ab", "cd", "e"], ["abcde"])
    True
    '''
    return "".join(first) == "".join(second)


if __name__ == "__main__":
    import doctest

    doctest.testmod()
