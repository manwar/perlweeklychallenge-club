#!/usr/bin/env python3


def duplicate_zero(elements):
    '''duplicate each occurrence of ZERO in the given array and shift 
    the remaining to the right but make sure the size of array remain 
    the same
    >>> duplicate_zero( [1, 0, 2, 3, 0, 4, 5, 0] )
    [1, 0, 0, 2, 3, 0, 0, 4]
    >>> duplicate_zero( [1, 2, 3] )
    [1, 2, 3]
    >>> duplicate_zero( [0, 3, 0, 4, 5] )
    [0, 0, 3, 0, 0]
    >>> duplicate_zero( [1, 2, 3, 0] )
    [1, 2, 3, 0]
    '''
    duplicate_zeroes = []
    elements_length = len(elements)
    for i in range(elements_length):
        if(elements[i] == 0):
            duplicate_zeroes.extend([0,0])
        else:
            duplicate_zeroes.append(elements[i])
        if len(duplicate_zeroes) >= elements_length:
            break
    return duplicate_zeroes[:elements_length]


if __name__ == "__main__":
    import doctest

    doctest.testmod()
