from typing import List


def is_reduced_row_echelon(matrix: list[list[int]]) -> int:
    last_leading = -1
    zero_row_encountered = False

    for row in matrix:
        if all(x == 0 for x in row):
            zero_row_encountered = True
            continue

        if zero_row_encountered:
            return 0  # Non-zero row after a zero row

        try:
            leading = next(i for i, x in enumerate(row) if x != 0)
        except StopIteration:
            continue  # Should not happen as zero rows are handled above

        # Check for leading 1 and correct position
        if row[leading] != 1 or leading <= last_leading:
            return 0

        # Check other elements in leading 1's column
        if any(
            matrix[i][leading] != 0
            for i in range(len(matrix))
            if i != matrix.index(row)
        ):
            return 0

        last_leading = leading

    return 1


# Test cases
assert is_reduced_row_echelon([[1, 1, 0], [0, 1, 0], [0, 0, 0]]) == 0
assert (
    is_reduced_row_echelon(
        [[0, 1, -2, 0, 1], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]]
    )
    == 1
)
assert is_reduced_row_echelon([[1, 0, 0, 4], [0, 1, 0, 7], [0, 0, 1, -1]]) == 1
assert (
    is_reduced_row_echelon(
        [[0, 1, -2, 0, 1], [0, 0, 0, 0, 0], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0]]
    )
    == 0
)
assert is_reduced_row_echelon([[0, 1, 0], [1, 0, 0], [0, 0, 0]]) == 0
assert is_reduced_row_echelon([[4, 0, 0, 0], [0, 1, 0, 7], [0, 0, 1, -1]]) == 0
