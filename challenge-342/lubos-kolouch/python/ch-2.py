import unittest


def max_score(s):
    if len(s) < 2:
        return 0  # Cannot split into two non-empty substrings

    max_score_val = 0
    # Iterate through all possible splits
    for i in range(1, len(s)):
        # Get left and right substrings
        left = s[:i]
        right = s[i:]

        # Count zeros in left
        zeros_left = left.count('0')

        # Count ones in right
        ones_right = right.count('1')

        # Compute score
        score = zeros_left + ones_right

        # Update max score
        max_score_val = max(max_score_val, score)

    return max_score_val


class TestMaxScore(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(max_score("0011"), 4)

    def test_example2(self):
        self.assertEqual(max_score("0000"), 3)

    def test_example3(self):
        self.assertEqual(max_score("1111"), 3)

    def test_example4(self):
        self.assertEqual(max_score("0101"), 3)

    def test_example5(self):
        self.assertEqual(max_score("011101"), 5)


if __name__ == '__main__':
    unittest.main()
