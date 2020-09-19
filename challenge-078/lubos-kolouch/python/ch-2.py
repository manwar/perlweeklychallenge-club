#!/bin/env python
""" https://perlweeklychallenge.org/blog/perl-weekly-challenge-078/
    Task 2
    Left Rotation
    19.9.2020 Lubos Kolouch """


class ListRotator:
    """ Rotate the array based on list of elems """

    def __init__(self, arr: list(), elems: list()):
        self.arr = arr
        self.elems = elems

    def rotate_arr(self, first: int):
        """ Rotate the array so that passed elem is first """

        return self.arr[first:] + self.arr[0:first]

    def process_offset(self):
        """ Process the list of elems for rotation """

        output = list()

        for elem in self.elems:
            output.append(self.rotate_arr(elem))

        return output


test_list = ListRotator(arr=[10, 20, 30, 40, 50], elems=[3, 4])
assert test_list.process_offset() == [[40, 50, 10, 20, 30], [50, 10, 20, 30, 40]]

test_list = ListRotator(arr=[7, 4, 2, 6, 3], elems=[1, 3, 4])
assert test_list.process_offset() == [[4, 2, 6, 3, 7], [6, 3, 7, 4, 2], [3, 7, 4, 2, 6]]
