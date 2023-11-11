import unittest
from typing import List


def flip_matrix(matrix: list[list[int]]) -> list[list[int]]:
    """
    Flip the given matrix by reversing each row and inverting each element.

    :param matrix: A list of lists representing the binary matrix.
    :return: The flipped matrix.
    """
    return [[1 - element for element in reversed(row)] for row in matrix]


# Test cases
class TestFlipMatrix(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(
            flip_matrix([[1, 1, 0], [1, 0, 1], [0, 0, 0]]),
            [[1, 0, 0], [0, 1, 0], [1, 1, 1]],
        )
        self.assertEqual(
            flip_matrix([[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]]),
            [[1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0]],
        )


if __name__ == "__main__":
    unittest.main()
