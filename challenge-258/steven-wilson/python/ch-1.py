#!/usr/bin/env python3


def count_even_digits_number(*integers):
    ''' Given a array of positive integers, find out how many have even
    number of digits
    >>> count_even_digits_number(10, 1, 111, 24, 1000)
    3
    >>> count_even_digits_number(111, 1, 11111)
    0
    >>> count_even_digits_number(2, 8, 1024, 256)
    1
    '''
    if not all(isinstance(num, int) and num > 0 for num in integers):
        raise ValueError("Input must consist of positive integers")

    return len([num for num in integers if len(str(num)) % 2 == 0])


if __name__ == "__main__":
    import doctest

    doctest.testmod()
