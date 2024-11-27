import unittest


def minimum_swaps(ints: list[int]) -> int:
    """
    Calculates the minimum number of adjacent swaps needed to make the given
    permutation a semi-ordered permutation.

    Args:
        ints (List[int]): The input permutation of integers.

    Returns:
        int: The minimum number of swaps required.
    """
    n = len(ints)
    pos1 = ints.index(1)
    posn = ints.index(n)

    if pos1 < posn:
        total_swaps = pos1 + (n - 1 - posn)
    else:
        total_swaps = pos1 + (n - 1 - posn) - 1

    return total_swaps


# Unit Tests
class TestMinimumSwaps(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(minimum_swaps([2, 1, 4, 3]), 2, 'Example 1 failed')

    def test_example2(self):
        self.assertEqual(minimum_swaps([2, 4, 1, 3]), 3, 'Example 2 failed')

    def test_example3(self):
        self.assertEqual(minimum_swaps([1, 3, 2, 4, 5]), 0, 'Example 3 failed')


if __name__ == '__main__':
    unittest.main()
