#!/usr/bin/env python
""" PerlWeeklyChallenge 53"""

import numpy as np
import pytest


class ArrRotator:
    """ Rotator class for rotating the array"""

    def __init__(self):
        self.arr = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
        self.degree = 0

    def check_degree(self):
        """ check if the degree is valid"""
        if self.degree not in (90, 180, 270):
            raise ValueError('degree must be 90, 180 or 270')

    def rotate_arr(self, degree: int):
        """do the rotation"""

        self.degree = degree
        self.check_degree()

        result_arr = self.arr

        for _ in range(degree // 90):
            result_arr = np.rot90(result_arr, -1)

        return result_arr


class RotatorTest:
    """Run the tests"""

    def __init__(self):
        self.rotator = ArrRotator()

    def do_tests(self):
        """ Run the tests for 90, 180, 270 degrees """

        assert np.alltrue(self.rotator.rotate_arr(degree=90)
                          == [[7, 4, 1], [8, 5, 2], [9, 6, 3]])
        assert np.alltrue(self.rotator.rotate_arr(degree=180)
                          == [[9, 8, 7], [6, 5, 4], [3, 2, 1]])
        assert np.alltrue(self.rotator.rotate_arr(degree=270)
                          == [[3, 6, 9], [2, 5, 8], [1, 4, 7]])
        with pytest.raises(ValueError):
            self.rotator.rotate_arr(degree=222)


def main():
    """ Run the program and tests """
    rotator = ArrRotator()

    print('Original array:')
    print(rotator.arr)
    print('Rotate by 90 : ')
    print(rotator.rotate_arr(degree=90))

    print('Rotate by 180 : ')
    print(rotator.rotate_arr(degree=180))

    print('Rotate by 270 : ')
    print(rotator.rotate_arr(degree=270))

    tester = RotatorTest()
    tester.do_tests()


if __name__ == "__main__":
    main()
