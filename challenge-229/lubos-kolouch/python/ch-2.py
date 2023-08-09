import unittest
from typing import List


def two_out_of_three(array1: List[int], array2: List[int], array3: List[int]) -> List[int]:
    count = {}

    # Count the occurrences of elements in each array using unique values for each array
    for num in array1:
        count[num] = count.get(num, 0) + 1
    for num in array2:
        count[num] = count.get(num, 0) + 2
    for num in array3:
        count[num] = count.get(num, 0) + 4

    # Select elements that appear in at least two arrays
    return sorted(key for key, value in count.items() if value in {1+2, 2+4, 1+4, 1+2+4})


class TestTwoOutOfThree(unittest.TestCase):
    def test_case_1(self):
        self.assertEqual(two_out_of_three([1, 1, 2, 4], [2, 4], [4]), [2, 4])

    def test_case_2(self):
        self.assertEqual(two_out_of_three([4, 1], [2, 4], [1, 2]), [1, 2, 4])


if __name__ == '__main__':
    unittest.main()
