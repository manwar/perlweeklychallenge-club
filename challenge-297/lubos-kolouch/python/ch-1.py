import unittest


def find_max_length(binary: list[int]) -> int:
    """
    Finds the maximum length of a contiguous subarray with equal numbers of 0 and 1.

    Args:
        binary (List[int]): The input list of binary numbers (0s and 1s).

    Returns:
        int: The maximum length of the contiguous subarray.
    """
    # Map 0 to -1 and 1 remains 1
    mapped = [-1 if x == 0 else 1 for x in binary]
    sum_indices = {}  # Stores the first occurrence of each cumulative sum
    max_length = 0
    cumulative_sum = 0

    for i, num in enumerate(mapped):
        cumulative_sum += num

        if cumulative_sum == 0:
            # Subarray from index 0 to i has equal number of 0s and 1s
            max_length = i + 1
        elif cumulative_sum in sum_indices:
            # Found a subarray with equal number of 0s and 1s
            length = i - sum_indices[cumulative_sum]
            if length > max_length:
                max_length = length
        else:
            # Store the first occurrence of this cumulative sum
            sum_indices[cumulative_sum] = i

    return max_length


# Unit Tests
class TestFindMaxLength(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(find_max_length([1, 0]), 2, 'Example 1 failed')

    def test_example2(self):
        self.assertEqual(find_max_length([0, 1, 0]), 2, 'Example 2 failed')

    def test_example3(self):
        self.assertEqual(find_max_length([0, 0, 0, 0, 0]), 0, 'Example 3 failed')

    def test_example4(self):
        self.assertEqual(find_max_length([0, 1, 0, 0, 1, 0]), 4, 'Example 4 failed')

    def test_empty(self):
        self.assertEqual(find_max_length([]), 0, 'Empty input failed')

    def test_no_equal_subarray(self):
        self.assertEqual(find_max_length([0, 0, 0, 1, 1]), 4, 'No equal subarray test failed')

    def test_long_array(self):
        binary = [0, 1] * 1000  # 2000 elements
        self.assertEqual(find_max_length(binary), 2000, 'Long array test failed')


if __name__ == '__main__':
    unittest.main()
