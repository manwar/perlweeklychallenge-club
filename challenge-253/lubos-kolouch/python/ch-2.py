from typing import List


def weakest_row(matrix: list[list[int]]) -> list[int]:
    """
    Returns the indices of the rows in the matrix sorted from the weakest to the strongest.

    A row is considered weaker if it has fewer 1s or, in case of a tie, has a lower index.

    :param matrix: A list of lists representing the binary matrix.
    :return: A list of integers representing the order of rows from weakest to strongest.
    """
    # Count the number of 1s in each row and keep track of the row index
    row_strength = [(sum(row), index) for index, row in enumerate(matrix)]

    # Sort based on the number of 1s and then by row index
    row_strength.sort()

    # Extract and return the sorted indices
    return [index for _, index in row_strength]


# Test the function
assert weakest_row(
    [
        [1, 1, 0, 0, 0],
        [1, 1, 1, 1, 0],
        [1, 0, 0, 0, 0],
        [1, 1, 0, 0, 0],
        [1, 1, 1, 1, 1],
    ]
) == [2, 0, 3, 1, 4]

assert weakest_row([[1, 0, 0, 0], [1, 1, 1, 1], [1, 0, 0, 0], [1, 0, 0, 0]]) == [
    0,
    2,
    3,
    1,
]
