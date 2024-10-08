import re
import unittest
from typing import List


def luhn_algorithm(s: str) -> bool:
    """
    Validates the input string using Luhn's Algorithm.

    Steps:
    1. Extract all digits from the input string.
    2. The last digit is the payload (check digit).
    3. Starting from the right (excluding the payload), double every other digit.
    4. If the result is greater than 9, subtract 9 from it.
    5. Sum all the adjusted digits.
    6. Calculate the correct check digit needed to bring the total modulo 10 to zero.
    7. Return True if the payload matches the correct check digit, False otherwise.

    Args:
        s (str): The input string containing digits and possibly other characters.

    Returns:
        bool: True if the payload matches the correct check digit, False otherwise.
    """
    digits = [int(d) for d in re.findall(r"\d", s)]
    if len(digits) < 2:
        return False  # Not enough digits to process

    payload = digits.pop()
    digits.reverse()  # Process from right to left excluding payload

    for i in range(len(digits)):
        if i % 2 == 0:
            digits[i] *= 2
            if digits[i] > 9:
                digits[i] -= 9

    total = sum(digits) + payload
    correct_check_digit = (10 - (sum(digits) % 10)) % 10

    return payload == correct_check_digit


# Unit Tests
class TestLuhnAlgorithm(unittest.TestCase):
    def test_example1(self):
        self.assertTrue(luhn_algorithm("17893729974"), "Example 1")

    def test_example2(self):
        self.assertTrue(luhn_algorithm("4137 8947 1175 5904"), "Example 2")

    def test_example3(self):
        self.assertFalse(luhn_algorithm("4137 8974 1175 5904"), "Example 3")

    def test_invalid_input(self):
        self.assertFalse(luhn_algorithm("abc"), "Invalid input with no digits")

    def test_single_digit(self):
        self.assertFalse(luhn_algorithm("5"), "Single digit input")

    def test_non_digit_characters(self):
        self.assertTrue(
            luhn_algorithm("4-1-3-7 8*9*4*7 1!1@7#5$5%9^0&4"),
            "Input with special characters",
        )


if __name__ == "__main__":
    unittest.main()
