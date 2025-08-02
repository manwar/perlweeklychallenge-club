#!/usr/bin/env python3


def distribute_elements(integers):
    ''' Given an array of distinct integers, distribute the elements as
    described below:

        1) Put the 1st element of the given array to a new array arr1.
        2) Put the 2nd element of the given array to a new array arr2.

    Once you have one element in each arrays, arr1 and arr2, then follow the
    rule below:

        If the last element of the array arr1 is greater than the last
        element of the array arr2 then add the first element of the
        given array to arr1 otherwise to the array arr2.

    When done distribution, return the concatenated arrays. arr1 and arr2.

    >>> distribute_elements([2, 1, 3, 4, 5])
    (2, 3, 4, 5, 1)
    >>> distribute_elements([3, 2, 4])
    (3, 4, 2)
    >>> distribute_elements([5, 4, 3 ,8])
    (5, 3, 4, 8)
    '''
    first = [integers[0]]
    second = [integers[1]]

    for i in integers[2:]:
        if first[-1] > second[-1]:
            first.append(i)
        else:
            second.append(i)

    return tuple(first + second)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
