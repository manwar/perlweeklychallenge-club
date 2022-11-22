from statistics import mean
from unittest import main, TestCase

"""
Example 1:
    Input: @list = (1, 0, 5)
    Output: 4
Example 2:
    Input: @list = (0, 2, 0)
    Output: -1
Example 3:
    Input: (0, 3, 0)
    Output: 2
"""

cases = [
    ([1, 0, 5], 4),
    ([0, 2, 0], -1),
    ([0, 3, 0], 2),
]


class TestSolutionII(TestCase):

    def equal_distro(self, _list):
        m = int(mean(_list))
        if m == 0:
            return -1
        else:
            return m + m

    def test_equal_distribution(self):
        for input, output in cases:
            with self.subTest(input=output):
                self.assertEqual(self.equal_distro(input), output)


if __name__ == "__main__":
    main(verbosity=2)
