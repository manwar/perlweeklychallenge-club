from typing import List


def is_x_matrix(matrix: List[List[int]]) -> bool:
    n = len(matrix)
    return all(
        (
            (matrix[i][i] != 0 and matrix[i][n - 1 - i] != 0)
            if i == j or j == n - 1 - i
            else matrix[i][j] == 0
        )
        for i in range(n)
        for j in range(n)
    )


# Test cases
assert is_x_matrix([[1, 0, 0, 2], [0, 3, 4, 0], [0, 5, 6, 0], [7, 0, 0, 1]]) is True
assert is_x_matrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]]) is False
assert is_x_matrix([[1, 0, 2], [0, 3, 0], [4, 0, 5]]) is True
