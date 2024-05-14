from typing import List
import unittest


def distribute_elements(ints: List[int]) -> List[int]:
    """
    Distribute elements of the given list into two separate lists according to the specified rules
    and return the concatenated result.

    Args:
    ints (List[int]): The input list of distinct integers.

    Returns:
    List[int]: The concatenated list of elements from the two distributed lists.
    """
    arr1 = []
    arr2 = []

    # Initial placement
    if ints:
        arr1.append(ints.pop(0))
    if ints:
        arr2.append(ints.pop(0))

    # Distribute remaining elements
    for elem in ints:
        if arr1[-1] > arr2[-1]:
            arr1.append(elem)
        else:
            arr2.append(elem)

    # Concatenate and return result
    return arr1 + arr2


# Unit tests
class TestDistributeElements(unittest.TestCase):
    def test_example_1(self):
        self.assertEqual(distribute_elements([2, 1, 3, 4, 5]), [2, 3, 4, 5, 1])

    def test_example_2(self):
        self.assertEqual(distribute_elements([3, 2, 4]), [3, 4, 2])

    def test_example_3(self):
        self.assertEqual(distribute_elements([5, 4, 3, 8]), [5, 3, 4, 8])


if __name__ == "__main__":
    unittest.main()
