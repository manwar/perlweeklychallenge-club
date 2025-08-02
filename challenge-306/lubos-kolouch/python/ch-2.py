import unittest


def last_element(ints: list[int]) -> int:
    """
    Determine the last element left after repeatedly picking and processing the two largest elements.

    The process is:
    1. Pick the two largest elements (x and y).
    2. If x == y, remove both.
    3. If x != y, remove both and add (x - y) to the array.
    Repeat until at most one element remains.

    Args:
        ints (list[int]): List of integers.

    Returns:
        int: The last remaining element, or 0 if none.

    Examples:
        >>> last_element([3, 8, 5, 2, 9, 2])
        1
        >>> last_element([3, 2, 5])
        0
    """
    import heapq
    # Use a max-heap by storing negatives
    heap = [-x for x in ints]
    heapq.heapify(heap)
    while len(heap) >= 2:
        x = -heapq.heappop(heap)
        y = -heapq.heappop(heap)
        if x != y:
            diff = x - y
            heapq.heappush(heap, -diff)
    return -heap[0] if heap else 0


# Unit tests


class TestLastElement(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(last_element([3, 8, 5, 2, 9, 2]), 1)

    def test_example2(self):
        self.assertEqual(last_element([3, 2, 5]), 0)

    def test_single_element(self):
        self.assertEqual(last_element([5]), 5)

    def test_two_equal_elements(self):
        self.assertEqual(last_element([5, 5]), 0)

    def test_three_equal_elements(self):
        self.assertEqual(last_element([10, 10, 10]), 10)

    def test_diff_after_removal(self):
        self.assertEqual(last_element([7, 3, 7]), 3)


if __name__ == '__main__':
    unittest.main()
