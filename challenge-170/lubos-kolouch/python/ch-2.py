""" Challenge 170 Task 2"""
import numpy as np


def get_kronecker_product(matrix: dict) -> np.ndarray:
    """Compute the Kronecker product"""

    matrix_a = matrix["a"]
    matrix_b = matrix["b"]

    # will be used in calculating the right position in the output
    row_len = len(matrix_a)

    # it is the same, just for code readability
    col_len = len(matrix_a)

    result = np.empty((row_len * row_len, col_len * col_len))

    # process the matrix a row by row

    # row by row
    for a_row_pos, row in enumerate(matrix_a):

        # column by column
        for a_col_pos, a_item in enumerate(row):

            # mutiply each number with matrix b

            for b_row_pos, b_row in enumerate(matrix_b):
                for b_col_pos, b_item in enumerate(b_row):

                    # calculate the right position in the output matrix
                    result[a_row_pos * row_len + b_row_pos][
                        a_col_pos * col_len + b_col_pos
                    ] = (a_item * b_item)

    return result


in_hash = {
    "a": [[1, 2], [3, 4]],
    "b": [[5, 6], [7, 8]],
}


assert np.array_equal(
    get_kronecker_product(in_hash),
    np.array(
        [
            [5, 6, 10, 12],
            [7, 8, 14, 16],
            [15, 18, 20, 24],
            [21, 24, 28, 32],
        ]
    ),
)
