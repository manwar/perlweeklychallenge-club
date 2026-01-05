import unittest

def fomatThousands(num:int) -> str:
    out = f"{num:,}" 
    return out
    

class ChallengeRunner(unittest.TestCase):

    def test_example_01(self):
        self.assertEqual(fomatThousands(123), "123")

    def test_example_02(self):
        self.assertEqual(fomatThousands(1234), "1,234")

    def test_example_03(self):
        self.assertEqual(fomatThousands(1000000), "1,000,000" )

    def test_example_04(self):
        self.assertEqual(fomatThousands(1), "1")

    def test_example_05(self):
        self.assertEqual(fomatThousands(12345), "12,345" )

if __name__ == '__main__':
    unittest.main()