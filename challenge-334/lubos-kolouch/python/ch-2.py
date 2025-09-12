#!/usr/bin/env python3
"""
Perl Weekly Challenge 334, Task 2: Nearest Valid Point

Given a current location (x, y) and a list of points, find the index of the valid point
(sharing x or y coordinate) with the smallest Manhattan distance. Return -1 if no valid points exist.

Args:
    x (int): Current x-coordinate
    y (int): Current y-coordinate
    points (List[List[int]]): List of points, each point is [x, y]

Returns:
    int: Index of the closest valid point, or -1 if none exist
"""

import unittest


def nearest_valid_point(x: int, y: int, points: list[list[int]]) -> int:
    min_distance = float('inf')
    min_index = -1

    for i, point in enumerate(points):
        px, py = point

        # Check if point is valid (shares x or y coordinate)
        if px == x or py == y:
            # Calculate Manhattan distance
            distance = abs(px - x) + abs(py - y)

            # Update min distance and index if this distance is smaller
            if distance < min_distance:
                min_distance = distance
                min_index = i

    return min_index


class TestNearestValidPoint(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(
            nearest_valid_point(3, 4, [[1, 2], [3, 1], [2, 4], [2, 3]]), 2)

    def test_example2(self):
        self.assertEqual(
            nearest_valid_point(2, 5, [[3, 4], [2, 3], [1, 5], [2, 5]]), 3)

    def test_example3(self):
        self.assertEqual(nearest_valid_point(1, 1, [[2, 2], [3, 3], [4, 4]]),
                         -1)

    def test_example4(self):
        self.assertEqual(
            nearest_valid_point(0, 0, [[0, 1], [1, 0], [0, 2], [2, 0]]), 0)

    def test_example5(self):
        self.assertEqual(
            nearest_valid_point(5, 5, [[5, 6], [6, 5], [5, 4], [4, 5]]), 0)


if __name__ == '__main__':
    unittest.main()
