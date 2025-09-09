def highest_row(matrix: list[list[int]]) -> int:
    """
    Find the highest row sum in a given m x n matrix.

    Args:
        matrix (List[List[int]]): A 2D list representing the matrix.

    Returns:
        int: The maximum sum of any row in the matrix.
    """
    if not matrix or not matrix[0]:
        return 0

    max_sum = 0
    for row in matrix:
        row_sum = sum(row)
        max_sum = max(max_sum, row_sum)

    return max_sum


# Unit tests
if __name__ == '__main__':
    import unittest

    class TestHighestRow(unittest.TestCase):

        def test_example1(self):
            self.assertEqual(
                highest_row([[4, 4, 4, 4], [10, 0, 0, 0], [2, 2, 2, 9]]), 16)

        def test_example2(self):
            self.assertEqual(highest_row([[1, 5], [7, 3], [3, 5]]), 10)

        def test_example3(self):
            self.assertEqual(highest_row([[1, 2, 3], [3, 2, 1]]), 6)

        def test_example4(self):
            self.assertEqual(highest_row([[2, 8, 7], [7, 1, 3], [1, 9, 5]]),
                             17)

        def test_example5(self):
            self.assertEqual(
                highest_row([[10, 20, 30], [5, 5, 5], [0, 100, 0],
                             [25, 25, 25]]), 100)

    unittest.main(argv=['first-arg-is-ignored'], exit=False)
