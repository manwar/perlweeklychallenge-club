#! /usr/bin/env python
""" Perl weekly challenge 073
    https://perlweeklychallenge.org/blog/perl-weekly-challenge-073/ Task 2 """


def get_smallest(arr):
    """Write a script to create an array that represents the
       smallest element to the left of each corresponding index.
       If none found then use 0. """

    return_array = list()
    return_array.append(0)

    my_min = arr[0]

    for i in range(1, len(arr)):
        if my_min < arr[i]:
            return_array.append(my_min)
        else:
            return_array.append(0)

        if arr[i] < my_min:
            my_min = arr[i]

    return return_array


assert get_smallest([7, 8, 3, 12, 10]) == [0, 7, 0, 3, 3]
assert get_smallest([4, 6, 5]) == [0, 4, 4]
