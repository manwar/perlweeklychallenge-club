import unittest


def balance_string(s):
    # Separate letters and digits
    letters = sorted([c for c in s if c.isalpha()])
    digits = sorted([c for c in s if c.isdigit()])

    # Check if valid rearrangement is possible
    if abs(len(letters) - len(digits)) > 1:
        return ""

    # Initialize result
    result = []
    i, j = 0, 0

    # Start with the more frequent type
    if len(letters) > len(digits):
        # Start with letter
        while i < len(letters) or j < len(digits):
            if i < len(letters):
                result.append(letters[i])
                i += 1
            if j < len(digits):
                result.append(digits[j])
                j += 1
    else:
        # Start with digit (or equal counts, digit first for lexicographical order)
        while i < len(letters) or j < len(digits):
            if j < len(digits):
                result.append(digits[j])
                j += 1
            if i < len(letters):
                result.append(letters[i])
                i += 1

    return "".join(result)


class TestBalanceString(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(balance_string("a0b1c2"), "0a1b2c")

    def test_example2(self):
        self.assertEqual(balance_string("abc12"), "a1b2c")

    def test_example3(self):
        self.assertEqual(balance_string("0a2b1c3"), "0a1b2c3")

    def test_example4(self):
        self.assertEqual(balance_string("1a23"), "")

    def test_example5(self):
        self.assertEqual(balance_string("ab123"), "1a2b3")


if __name__ == '__main__':
    unittest.main()
