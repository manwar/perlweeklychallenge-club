#!/usr/bin/env python3

# Importing the necessary libraries
import unittest


# Define the base35 class
class Base35:
    def __init__(self):
        self.digits = [
            "0",
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "A",
            "B",
            "C",
            "D",
            "E",
            "F",
            "G",
            "H",
            "I",
            "J",
            "K",
            "L",
            "M",
            "N",
            "O",
            "P",
            "Q",
            "R",
            "S",
            "T",
            "U",
            "V",
            "W",
            "X",
            "Y",
        ]

    # Function to convert int to base35
    def int2base35(self, n: int) -> str:
        if n < 0:
            raise ValueError("Negative numbers can't be converted to base35")
        elif n == 0:
            return "0"
        else:
            result = ""
            while n > 0:
                digit = self.digits[n % 35]
                result = digit + result
                n = n // 35
            return result

    # Function to convert base35 to int
    def base352int(self, b: str) -> int:
        result = 0
        for i, c in enumerate(b[::-1]):
            result += self.digits.index(c) * (35**i)
        return result


# Define the test class
class TestBase35(unittest.TestCase):
    # Set up the test class
    def setUp(self):
        self.base35 = Base35()

    # Test to convert int to base35
    def test_int2base35(self):
        self.assertEqual(self.base35.int2base35(100), "2U")
        self.assertEqual(self.base35.int2base35(200), "5P")

    # Test to convert base35 to int
    def test_base352int(self):
        self.assertEqual(self.base35.base352int("2U"), 100)
        self.assertEqual(self.base35.base352int("5P"), 200)


# Run the tests
if __name__ == "__main__":
    unittest.main()
