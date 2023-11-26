import unittest
from typing import List


def create_new_array(old: list[int]) -> list[int]:
    return [old[old[i]] for i in range(len(old))]


class TestCreateNewArray(unittest.TestCase):
    def test_cases(self):
        self.assertEqual(create_new_array([0, 2, 1, 5, 3, 4]), [0, 1, 2, 4, 5, 3])
        self.assertEqual(create_new_array([5, 0, 1, 2, 3, 4]), [4, 5, 0, 1, 2, 3])


if __name__ == "__main__":
    unittest.main()
