""" Perl Weekly Challenge 270 LK Task 1 Python """

from typing import List


def num_special_positions(matrix: List[List[int]]) -> int:
    """
    num_special_positions A position (i, j) is called special if $matrix[i][j] == 1 and all other elements in the row i and column j are 0.

    Args:
        matrix (List[List[int]]): input matrix

    Returns:
        int: count of special positions
    """

    rows = len(matrix)
    cols = len(matrix[0])

    def is_special(i: int, j: int) -> bool:
        for x in range(rows):
            if x != i and matrix[x][j] == 1:
                return False
        for y in range(cols):
            if y != j and matrix[i][y] == 1:
                return False
        return True

    special_count = 0
    for i in range(rows):
        for j in range(cols):
            if matrix[i][j] == 1 and is_special(i, j):
                special_count += 1

    return special_count


# Example 1
matrix1 = [[1, 0, 0], [0, 0, 1], [1, 0, 0]]
assert num_special_positions(matrix1) == 1

# Example 2
matrix2 = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]
assert num_special_positions(matrix2) == 3
