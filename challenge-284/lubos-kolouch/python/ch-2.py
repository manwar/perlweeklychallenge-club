from typing import List
import unittest


def relative_sort(list1: List[int], list2: List[int]) -> List[int]:
    """
    Sorts the elements of list1 based on the relative order defined in list2.
    Elements not in list2 are placed at the end in ascending order.

    Args:
        list1 (List[int]): The list of integers to sort.
        list2 (List[int]): The list defining the relative order.

    Returns:
        List[int]: The sorted list.
    """
    order = {num: idx for idx, num in enumerate(list2)}
    in_list2 = []
    not_in_list2 = []

    for num in list1:
        if num in order:
            in_list2.append(num)
        else:
            not_in_list2.append(num)

    # Sort elements in list1 that are in list2 based on the order in list2
    in_list2.sort(key=lambda x: (order[x], x))

    # Sort elements not in list2 in ascending order
    not_in_list2.sort()

    return in_list2 + not_in_list2


# Unit Tests
class TestRelativeSort(unittest.TestCase):

    def test_example1(self):
        list1 = [2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5]
        list2 = [2, 1, 4, 3, 5, 6]
        expected = [2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9]
        self.assertEqual(relative_sort(list1, list2), expected, 'Example 1')

    def test_example2(self):
        list1 = [3, 3, 4, 6, 2, 4, 2, 1, 3]
        list2 = [1, 3, 2]
        expected = [1, 3, 3, 3, 2, 2, 4, 4, 6]
        self.assertEqual(relative_sort(list1, list2), expected, 'Example 2')

    def test_example3(self):
        list1 = [3, 0, 5, 0, 2, 1, 4, 1, 1]
        list2 = [1, 0, 3, 2]
        expected = [1, 1, 1, 0, 0, 3, 2, 4, 5]
        self.assertEqual(relative_sort(list1, list2), expected, 'Example 3')

    def test_additional(self):
        list1 = [7, 5, 9, 4, 8, 6]
        list2 = [5, 7, 6]
        expected = [5, 7, 6, 4, 8, 9]
        self.assertEqual(relative_sort(list1, list2), expected,
                         'Additional Test')


if __name__ == "__main__":
    unittest.main()
