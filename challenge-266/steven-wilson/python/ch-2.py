#!/usr/bin/env python3


def is_x_matrix(matrix):
    ''' Given a square matrix, find if the given matrix is X Matrix.  A square
    matrix is an X Matrix if all the elements on the main diagonal and
    antidiagonal are non-zero and everything else are zero

    >>> is_x_matrix([[1, 0, 0, 2], [0, 3, 4, 0], [0, 5, 6, 0], [7, 0, 0, 1],])
    True
    >>> is_x_matrix([[1, 2, 3], [4, 5, 6], [7, 8, 9],])
    False
    >>> is_x_matrix([[1, 0, 2], [0, 3, 0], [4, 0, 5],])
    True
    '''
    matrix_size = len(matrix)
    for diagonal_position, row in enumerate(matrix):
        antidiagonal_position = matrix_size - diagonal_position - 1
        x = []
        if diagonal_position < antidiagonal_position:
            x.append(row.pop(antidiagonal_position))
            x.append(row.pop(diagonal_position))
        elif diagonal_position == antidiagonal_position:
            x.append(row.pop(diagonal_position))
        else:
            x.append(row.pop(diagonal_position))
            x.append(row.pop(antidiagonal_position))
        if not all(elem != 0 for elem in x) or not all(elem == 0 for elem in row):
            return False

    return True


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
