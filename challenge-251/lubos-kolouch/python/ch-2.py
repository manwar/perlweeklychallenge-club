from typing import List


def lucky_number(matrix: list[list[int]]) -> int:
    """
    Returns the lucky number in the given matrix, if there is one, or -1 if not.

    A lucky number is an element of the matrix such that it is the minimum element in its row and maximum in its column.

    Args:
        matrix: A list of lists of integers representing the matrix.

    Returns:
        An integer representing the lucky number, or -1 if there is no lucky number in the matrix.
    """
    for i in range(len(matrix)):
        min_row = min(matrix[i])
        min_index = matrix[i].index(min_row)
        if all(matrix[j][min_index] <= min_row for j in range(len(matrix))):
            return min_row
    return -1


# Example usage
matrix1 = [[3, 7, 8], [9, 11, 13], [15, 16, 17]]
print(lucky_number(matrix1))  # Output: 15

matrix2 = [[1, 10, 4, 2], [9, 3, 8, 7], [15, 16, 17, 12]]
print(lucky_number(matrix2))  # Output: 12

matrix3 = [[7, 8], [1, 2]]
print(lucky_number(matrix3))  # Output: 7
