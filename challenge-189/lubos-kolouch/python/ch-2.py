#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest


def array_degree(array):
    count = {}
    start = {}
    end = {}

    # Determine the frequency of each element and the start and end indices
    for i, num in enumerate(array):
        count[num] = count.get(num, 0) + 1
        if num not in start:
            start[num] = i
        end[num] = i

    # Find the degree of the array
    degree = max(count.values())

    # Find the smallest slice with the same degree
    min_length = len(array)
    result = []
    for num in count:
        if count[num] == degree:
            length = end[num] - start[num] + 1
            if length < min_length:
                min_length = length
                result = array[start[num]:end[num] + 1]

    return result


class TestArrayDegree(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(array_degree([1, 3, 3, 2]), [3, 3])
        self.assertEqual(array_degree([1, 2, 1, 3]), [1, 2, 1])
        self.assertEqual(array_degree([1, 3, 2, 1, 2]), [2, 1, 2])
        self.assertEqual(array_degree([1, 1, 2, 3, 2]), [1, 1])
        self.assertEqual(array_degree([2, 1, 2, 1, 1]), [1, 2, 1, 1])


if __name__ == '__main__':
    unittest.main()
