import unittest


def shuffle_string(string, indices):
    chars = list(string)
    shuffled = [None] * len(string)

    for i, idx in enumerate(indices):
        shuffled[idx] = chars[i]

    return "".join(shuffled)


class TestShuffle(unittest.TestCase):
    def test_shuffle(self):
        string = "lacelengh"
        indices = [3, 2, 0, 5, 4, 8, 6, 7, 1]
        self.assertEqual(shuffle_string(string, indices), "challenge")

        string = "rulepark"
        indices = [4, 7, 3, 1, 0, 5, 2, 6]
        self.assertEqual(shuffle_string(string, indices), "perlraku")


if __name__ == "__main__":
    unittest.main()
