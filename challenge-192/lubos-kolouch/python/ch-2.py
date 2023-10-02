import unittest


def equal_distribution(list_):
    total_sum = sum(list_)

    if total_sum % len(list_) != 0:
        return -1

    target = total_sum // len(list_)
    moves = 0

    # Repeat until the distribution is complete
    while True:
        done = True

        # Distribute the difference to adjacent cells
        for i in range(len(list_) - 1):
            if list_[i] < target:
                list_[i] += 1
                list_[i+1] -= 1
                moves += 1
                done = False
            elif list_[i] > target:
                list_[i] -= 1
                list_[i+1] += 1
                moves += 1
                done = False

        # Break if the distribution is complete
        if done:
            break

    return moves


class TestEqualDistribution(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(equal_distribution([1, 0, 5]), 4)
        self.assertEqual(equal_distribution([0, 2, 0]), -1)
        self.assertEqual(equal_distribution([0, 3, 0]), 2)


if __name__ == '__main__':
    unittest.main()
