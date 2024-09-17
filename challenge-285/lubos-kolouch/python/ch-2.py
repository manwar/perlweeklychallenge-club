from typing import List
import unittest


def making_change(amount: int) -> int:
    """
    Compute the number of ways to make change for the given amount in cents using US coins.

    Coins available:
    - Penny (P): 1 cent
    - Nickel (N): 5 cents
    - Dime (D): 10 cents
    - Quarter (Q): 25 cents
    - Half-dollar (HD): 50 cents

    Order of coin selection does not matter.

    Args:
        amount (int): The amount in cents (non-negative integer).

    Returns:
        int: The number of distinct ways to make change.
    """
    coins = [1, 5, 10, 25, 50]
    dp = [0] * (amount + 1)
    dp[0] = 1  # There is one way to make 0 cents

    for coin in coins:
        for i in range(coin, amount + 1):
            dp[i] += dp[i - coin]

    return dp[amount]


# Unit Tests
class TestMakingChange(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(making_change(9), 2, 'Example 1')

    def test_example2(self):
        self.assertEqual(making_change(15), 6, 'Example 2')

    def test_example3(self):
        self.assertEqual(making_change(100), 292, 'Example 3')

    def test_zero_amount(self):
        self.assertEqual(making_change(0), 1, 'Zero amount')

    def test_negative_amount(self):
        with self.assertRaises(IndexError):
            making_change(-1)


if __name__ == "__main__":
    unittest.main()
