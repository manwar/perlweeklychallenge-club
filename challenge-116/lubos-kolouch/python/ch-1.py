import unittest


def split_number(n):
    result = []
    if n >= 10:
        digits = [int(x) for x in str(n)]
        first = digits[0]
        result.append(first)
        for digit in digits[1:]:
            if digit - first == 1:
                result.append(digit)
                first = digit
            else:
                result = [n]
                break
    return ','.join(map(str, result))


class TestSplitNumber(unittest.TestCase):

    def test_1(self):
        self.assertEqual(split_number(1234), "1,2,3,4")

    def test_2(self):
        self.assertEqual(split_number(91011), "9,10,11")

    def test_3(self):
        self.assertEqual(split_number(10203), "10203")


if __name__ == '__main__':
    unittest.main()
