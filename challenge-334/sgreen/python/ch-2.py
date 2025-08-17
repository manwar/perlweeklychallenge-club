#!/usr/bin/env python3

from dataclasses import dataclass
import sys


@dataclass(frozen=True)
class Point:
    """A point in 2D space with x and y coordinates."""
    x: int
    y: int

    def __sub__(self, other: 'Point') -> int:
        """Calculate the Manhattan distance between this point and another."""
        return abs(self.x - other.x) + abs(self.y - other.y)


def shortest_index(x: int, y: int, points_list: list[list[int]]) -> int:
    """Find the index of the point closest to (x, y) that shares either x or y coordinate.
    If no such point exists, return -1.

    Args:
        x (int): The x coordinate of the starting point.
        y (int): The y coordinate of the starting point.
        points_list (list[list[int]]): A list of points, each represented as a list of two integers [x, y].

    Returns:
        int: The index of the closest point that shares either x or y coordinate, or -1 if none exists.
    """

    # Turn the input parameters into Point objects
    starting_point = Point(x, y)
    points = [Point(*point) for point in points_list]

    # Initialize variables to track the minimum distance and corresponding index
    min_distance = None
    min_index = -1

    for index, point in enumerate(points):
        # Check if the point shares either x or y coordinate with the starting point
        if point.x != starting_point.x and point.y != starting_point.y:
            continue

        # Calculate the distance from the starting point to the current point
        # and update the minimum distance and index if necessary
        distance = starting_point - point
        if min_distance is None or distance < min_distance:
            min_distance = distance
            min_index = index

    # Return the index of the closest point, or -1 if no such point was found
    return min_index


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    x = array.pop(0)  # First element is x
    y = array.pop(0)  # Second element is y
    points = [array[i:i + 2] for i in range(0, len(array), 2)]
    result = shortest_index(x, y, points)
    print(result)


if __name__ == '__main__':
    main()
