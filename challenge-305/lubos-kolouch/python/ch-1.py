import unittest


def is_prime(n: int) -> bool:
    if n <= 1:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    for i in range(3, int(n**0.5) + 1, 2):
        if n % i == 0:
            return False
    return True


def binary_prefix(binary: list[int]) -> list[bool]:
    current_num = 0
    result = []
    for bit in binary:
        current_num = current_num * 2 + bit
        result.append(is_prime(current_num))
    return result


class TestBinaryPrefix(unittest.TestCase):

    def test_example1(self):
        binary = [1, 0, 1]
        expected = [False, True, True]
        self.assertEqual(binary_prefix(binary), expected)

    def test_example2(self):
        binary = [1, 1, 0]
        expected = [False, True, False]
        self.assertEqual(binary_prefix(binary), expected)

    def test_example3(self):
        binary = [1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1]
        expected = [
            False, True, True, False, False, True, False, False, False, False,
            False, False, False, False, False, False, False, False, False, True
        ]
        self.assertEqual(binary_prefix(binary), expected)

    def test_edge_cases(self):
        self.assertEqual(binary_prefix([0]), [False])
        self.assertEqual(binary_prefix([1]), [False])
        self.assertEqual(binary_prefix([0, 0, 0]), [False, False, False])
        self.assertEqual(binary_prefix([1, 0]), [False, True])


if __name__ == '__main__':
    unittest.main()
