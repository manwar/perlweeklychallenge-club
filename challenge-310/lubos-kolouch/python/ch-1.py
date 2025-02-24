import unittest


def arrays_intersection(arrays: list[list[int]]) -> list[int]:
    """
    Find the common elements in all given arrays.

    Args:
        arrays: List of integer lists to find intersection of

    Returns:
        List of integers that are common to all input arrays
    """
    if not arrays:
        return []

    # Start with first array as set
    common: set[int] = set(arrays[0])

    # Intersect with remaining arrays
    for arr in arrays[1:]:
        common.intersection_update(arr)

    return sorted(common)


class TestArraysIntersection(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(
            arrays_intersection([[1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3]]),
            [1, 4])

    def test_example2(self):
        self.assertEqual(arrays_intersection([[1, 0, 2, 3], [2, 4, 5]]), [2])

    def test_example3(self):
        self.assertEqual(arrays_intersection([[1, 2, 3], [4, 5], [6]]), [])

    def test_empty_input(self):
        self.assertEqual(arrays_intersection([]), [])

    def test_single_array(self):
        self.assertEqual(arrays_intersection([[1, 2, 3]]), [1, 2, 3])


if __name__ == '__main__':
    unittest.main()
