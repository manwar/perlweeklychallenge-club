#! /usr/bin/env python
""" Perl weekly challenge 073
    https://perlweeklychallenge.org/blog/perl-weekly-challenge-073/ Task 1 """


def min_window(arr, s):
    """ Return the min sliding window"""

    return_array = list()

    pos = 0

    while 1:
        last_index = min(len(arr)-1, pos + s)

        app_min = min(arr[pos:last_index])
        return_array.append(app_min)

        if last_index == len(arr)-1:
            break

        pos += 1

    return return_array


assert min_window([1, 5, 0, 2, 9, 3, 7, 6, 4, 8], 3) == [0, 0, 0, 2, 3, 3, 4]
