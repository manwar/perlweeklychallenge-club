from typing import List
import unittest


def order_game(ints: List[int]) -> int:
    """
    Simulates the Order Game on the given list of integers.

    In the Order Game:
    - At each round, the array is reduced by pairing elements.
    - For each pair at an even index (starting from 0), take the minimum of the pair.
    - For each pair at an odd index, take the maximum of the pair.
    - Repeat the process until only one element remains.

    Args:
        ints (List[int]): A list of integers whose length is a power of 2.

    Returns:
        int: The last remaining integer after playing the game.
    """
    current_list = ints.copy()
    while len(current_list) > 1:
        next_list = []
        n = len(current_list)
        for i in range(n // 2):
            if i % 2 == 0:
                # Even index: take minimum
                next_list.append(
                    min(current_list[2 * i], current_list[2 * i + 1]))
            else:
                # Odd index: take maximum
                next_list.append(
                    max(current_list[2 * i], current_list[2 * i + 1]))
        current_list = next_list
    return current_list[0]


# Unit Tests
class TestOrderGame(unittest.TestCase):

    def test_example1(self):
        ints = [2, 1, 4, 5, 6, 3, 0, 2]
        self.assertEqual(order_game(ints), 1, 'Example 1')

    def test_example2(self):
        ints = [0, 5, 3, 2]
        self.assertEqual(order_game(ints), 0, 'Example 2')

    def test_example3(self):
        ints = [9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8]
        self.assertEqual(order_game(ints), 2, 'Example 3')

    def test_power_of_two_length(self):
        ints = [1, 2]
        self.assertEqual(order_game(ints), 1, 'Length 2 array')

    def test_large_array(self):
        ints = [i for i in range(16)]
        result = order_game(ints)
        self.assertIsInstance(result, int, 'Result is an integer')


if __name__ == "__main__":
    unittest.main()
