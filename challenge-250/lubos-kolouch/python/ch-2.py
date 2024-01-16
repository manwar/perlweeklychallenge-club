# Define a function to return the maximum value of alphanumeric string in an array
def max_alphanum_value(array: list[str]) -> int:
    # Initialize the maximum value to 0
    max_value = 0
    # Loop through each string in the array
    for s in array:
        # If the string is made up of digits only, convert it to an integer in base 10
        if s.isdigit():
            value = int(s, 10)
        # Otherwise, the value is the length of the string
        else:
            value = len(s)
        # Update the maximum value if the current value is greater
        if value > max_value:
            max_value = value
    # Return the maximum value
    return max_value


# Test the function with some examples
import unittest


class TestMaxAlphanumValue(unittest.TestCase):
    def test_example_1(self):
        self.assertEqual(max_alphanum_value(["perl", "2", "000", "python", "r4ku"]), 6)

    def test_example_2(self):
        self.assertEqual(max_alphanum_value(["001", "1", "000", "0001"]), 1)

    def test_empty_array(self):
        self.assertEqual(max_alphanum_value([]), 0)

    def test_all_digits(self):
        self.assertEqual(max_alphanum_value(["123", "456", "789"]), 789)

    def test_all_letters(self):
        self.assertEqual(max_alphanum_value(["abc", "def", "ghi"]), 3)


if __name__ == "__main__":
    unittest.main()
