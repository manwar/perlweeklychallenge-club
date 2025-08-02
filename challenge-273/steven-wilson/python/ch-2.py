#!/usr/bin/env python3


def b_after_a(string):
    ''' Given  a string, return true if there is at least one b, and no a
    appears after the first b.
    >>> b_after_a("aabb")
    True
    >>> b_after_a("abab")
    False
    >>> b_after_a("aaa")
    False
    >>> b_after_a("bbb")
    True
    '''
    first_b_index = string.find("b")
    if first_b_index != -1 and "a" not in string[first_b_index:]:
        return True
    return False


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
