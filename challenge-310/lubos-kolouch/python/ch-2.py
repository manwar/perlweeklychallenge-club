import unittest


def sort_odd_even_indices(ints: list[int]) -> list[int]:
    """
    Sort even index elements in increasing order and odd index elements in decreasing order.

    Args:
        ints: List of integers to be sorted

    Returns:
        List with even indices sorted ascending and odd indices sorted descending
    """
    # Separate even and odd indices
    evens = [ints[i] for i in range(0, len(ints), 2)]
    odds = [ints[i] for i in range(1, len(ints), 2)]

    # Sort them accordingly
    evens.sort()
    odds.sort(reverse=True)

    # Reconstruct the array
    result: list[int] = []
    e, o = 0, 0
    for i in range(len(ints)):
        if i % 2 == 0:
            result.append(evens[e])
            e += 1
        else:
            result.append(odds[o])
            o += 1

    return result


class TestSortOddEvenIndices(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(sort_odd_even_indices([4, 1, 2, 3]), [2, 3, 4, 1])

    def test_example2(self):
        self.assertEqual(sort_odd_even_indices([3, 1]), [3, 1])

    def test_example3(self):
        self.assertEqual(sort_odd_even_indices([5, 3, 2, 1, 4]),
                         [2, 3, 4, 1, 5])

    def test_empty_input(self):
        self.assertEqual(sort_odd_even_indices([]), [])

    def test_single_element(self):
        self.assertEqual(sort_odd_even_indices([5]), [5])


if __name__ == '__main__':
    unittest.main()
