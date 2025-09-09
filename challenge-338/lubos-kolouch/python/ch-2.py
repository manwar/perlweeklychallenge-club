def max_distance(arr1: list[int], arr2: list[int]) -> int:
    """
    Find the maximum difference between any pair of values from two integer arrays.

    Args:
        arr1 (List[int]): First integer array.
        arr2 (List[int]): Second integer array.

    Returns:
        int: The maximum absolute difference between any pair of values from the two arrays.
    """
    if not arr1 or not arr2:
        return 0

    max_diff = 0
    for x in arr1:
        for y in arr2:
            diff = abs(x - y)
            max_diff = max(max_diff, diff)

    return max_diff


# Unit tests
if __name__ == '__main__':
    import unittest

    class TestMaxDistance(unittest.TestCase):

        def test_example1(self):
            self.assertEqual(max_distance([4, 5, 7], [9, 1, 3, 4]), 6)

        def test_example2(self):
            self.assertEqual(max_distance([2, 3, 5, 4], [3, 2, 5, 5, 8, 7]), 6)

        def test_example3(self):
            self.assertEqual(max_distance([2, 1, 11, 3], [2, 5, 10, 2]), 9)

        def test_example4(self):
            self.assertEqual(max_distance([1, 2, 3], [3, 2, 1]), 2)

        def test_example5(self):
            self.assertEqual(max_distance([1, 0, 2, 3], [5, 0]), 5)

    unittest.main(argv=['first-arg-is-ignored'], exit=False)
