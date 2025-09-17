#!/usr/bin/env python3
"""
Perl Weekly Challenge 333, Task 1: Straight Line

Given a list of coordinates, determine if they form a straight line.

A set of points forms a straight line if they are collinear. This can be checked
by verifying that the slope between any pair of points is the same (or they are
all vertically aligned). For points (x1, y1), (x2, y2), (x3, y3), they are
collinear if (y2 - y1)(x3 - x1) == (y3 - y1)(x2 - x1).

Author: [Your Name]
"""
import unittest

Point = tuple[int, int]


def is_straight_line(points: list[Point]) -> bool:
    """
    Determine if the given points form a straight line.

    Args:
        points: List of tuples, each containing x and y coordinates.

    Returns:
        bool: True if points are collinear, False otherwise.
    """
    if len(points) < 2 or all(p[0] == points[0][0] and p[1] == points[0][1]
                              for p in points):
        return True

    # Check if all points are vertically aligned (same x-coordinate)
    if all(p[0] == points[0][0] for p in points):
        return True

    # Compute slope using cross product to avoid division
    dx1 = points[1][0] - points[0][0]
    dy1 = points[1][1] - points[0][1]

    # Check collinearity for all points against first two
    def collinear(index: int) -> bool:
        dx2 = points[index][0] - points[0][0]
        dy2 = points[index][1] - points[0][1]
        return dy2 * dx1 == dx2 * dy1

    return all(collinear(i) for i in range(2, len(points)))


# Unit Tests


class TestStraightLine(unittest.TestCase):

    def test_example1(self):
        """Test case: Points ([2,1], [2,3], [2,5]) form a straight line."""
        points = [(2, 1), (2, 3), (2, 5)]
        self.assertTrue(is_straight_line(points))

    def test_example2(self):
        """Test case: Points ([1,4], [3,4], [10,4]) form a straight line."""
        points = [(1, 4), (3, 4), (10, 4)]
        self.assertTrue(is_straight_line(points))

    def test_example3(self):
        """Test case: Points ([0,0], [1,1], [2,3]) do not form a straight line."""
        points = [(0, 0), (1, 1), (2, 3)]
        self.assertFalse(is_straight_line(points))

    def test_example4(self):
        """Test case: Points ([1,1], [1,1], [1,1]) form a straight line."""
        points = [(1, 1), (1, 1), (1, 1)]
        self.assertTrue(is_straight_line(points))

    def test_example5(self):
        """Test case: Points ([1000000,1000000], [2000000,2000000], [3000000,3000000]) form a straight line."""
        points = [(1000000, 1000000), (2000000, 2000000), (3000000, 3000000)]
        self.assertTrue(is_straight_line(points))


if __name__ == '__main__':
    unittest.main()
