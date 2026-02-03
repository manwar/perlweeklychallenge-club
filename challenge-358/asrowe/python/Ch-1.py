

import unittest

def maxStrValue(strings: list) -> int:
    def strValue(s: str):
        try:
            test = int(s)
            return test
        except ValueError:
            return len(s)

    out = max(map(strValue, strings))
    return out



class ChallengeRunner(unittest.TestCase):

    def test_case_1(self):
        self.assertEqual(maxStrValue(["123", "45", "6"]), 123)

    def test_case_2(self):
        self.assertEqual(maxStrValue(["abc", "de", "fghi"]), 4)

    def test_case_3(self):
        self.assertEqual(maxStrValue(["0012", "99", "a1b2c"]), 99)

    def test_case_4(self):
        self.assertEqual(maxStrValue(["x", "10", "xyz", "007"]), 10)

    def test_case_5(self):
        self.assertEqual(maxStrValue(["hello123", "2026", "perl"]), 2026)



if __name__ == '__main__':
    unittest.main()