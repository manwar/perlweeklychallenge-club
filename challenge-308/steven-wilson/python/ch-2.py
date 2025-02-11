#!/usr/bin/env python3


def decode_xor(initial, encoded):
    """ Given an encoded array and an initial integer, find the original array
    that produced the given encoded array. It was encoded such that
    encoded[i] = orig[i] XOR orig[i + 1].

    >>> decode_xor(1, (1, 2, 3))
    (1, 0, 2, 1)
    >>> decode_xor(4, (6, 2, 7, 3))
    (4, 2, 0, 7, 4)
    """
    decoded = [initial]

    for e in encoded:
        decoded.append(decoded[-1] ^ e)

    return tuple(decoded)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
