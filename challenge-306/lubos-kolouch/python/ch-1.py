import unittest


def odd_sum(arr: list[int]) -> int:
    """
    Calculate the sum of all possible odd-length subarrays of the given array.

    A subarray is a contiguous subsequence of the array. This function computes the sum of each
    element of every possible subarray with odd length and returns the total sum.

    Args:
        arr (list[int]): The array of positive integers.

    Returns:
        int: The sum of all odd-length subarrays.

    Examples:
        >>> odd_sum([2, 5, 3, 6, 4])
        77
        >>> odd_sum([1, 3])
        4
    """
    n = len(arr)
    prefix = [0] * (n + 1)
    for i in range(n):
        prefix[i + 1] = prefix[i] + arr[i]
    total = 0
    for length in range(1, n + 1, 2):
        max_start = n - length
        for start in range(max_start + 1):
            end = start + length
            total += prefix[end] - prefix[start]
    return total


# Unit tests


class TestOddSum(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(odd_sum([2, 5, 3, 6, 4]), 77)

    def test_example2(self):
        self.assertEqual(odd_sum([1, 3]), 4)

    def test_single_element(self):
        self.assertEqual(odd_sum([5]), 5)

    def test_length3(self):
        self.assertEqual(odd_sum([1, 2, 3]), 1 + 2 + 3 + (1 + 2 + 3))


if __name__ == '__main__':
    unittest.main()
