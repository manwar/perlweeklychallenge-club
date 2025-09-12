#!/usr/bin/env python3

from dataclasses import dataclass
import sys


@dataclass
class Point:
    """A point in the matrix."""
    x: int
    y: int

    def score(self, row:int, col:int) -> int:
        """Calculate the score for this point at the given row and column."""
        if row == self.x and col == self.y:
            return 2
        if row == self.x or col == self.y:
            return 1

        return 0

def odd_matrix(rows:int, cols:int, points_list: list) -> int:
    """Calculate the number of cells in the matrix with an odd score.

    Args:
        rows: Number of rows in the matrix.
        col: Number of columns in the matrix.
        points_list: List of (x, y) tuples representing points in the matrix.

    Returns:
        The number of cells in the matrix with an odd score.
    """
    # Convert the list of points into Point objects
    points = [Point(x, y) for x, y in points_list]
    odd_cells = 0

    for row in range(rows):
        for col in range(cols):
            # Calculate the score for this cell
            score = 0
            for point in points:
                score += point.score(row, col)

            # If the score is odd, increment the count of odd cells
            if score % 2 == 1:
                odd_cells += 1

    return odd_cells


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    row = array.pop(0)
    col = array.pop(0)
    points = [(array[i], array[i + 1]) for i in range(0, len(array), 2)]

    result = odd_matrix(row, col, points)
    print(result)


if __name__ == '__main__':
    main()
