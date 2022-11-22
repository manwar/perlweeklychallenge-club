import unittest


class TestSolutionI(unittest.TestCase):

    def binary_flip(self, n):
        mask = max(1, (1 << n.bit_length()) - 1)
        return n ^ mask

    def test_binary_flip(self):
        self.assertEqual(self.binary_flip(5), 2, "example 1")
        self.assertEqual(self.binary_flip(4), 3, "example 2")
        self.assertEqual(self.binary_flip(6), 1, "example 3")
        self.assertEqual(self.binary_flip(0), 1, "nasty edge case")
        self.assertEqual(self.binary_flip(-10), -7, "negative num edge case")


if __name__ == "__main__":
    unittest.main(verbosity=True)
