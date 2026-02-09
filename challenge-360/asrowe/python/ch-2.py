
import unittest

def orderWords(text: str) -> str:
    out = sorted(text.split(), key=lambda x: x.lower())
    return " ".join(out)



class ChallengeRunner(unittest.TestCase):

    def test_case_1(self):
        self.assertEqual(orderWords("The quick brown fox"), "brown fox quick The")

    def test_case_2(self):
        self.assertEqual(orderWords("Hello    World!   How   are you?"), "are Hello How World! you?")

    def test_case_3(self):
        self.assertEqual(orderWords("Hello"), "Hello")

    def test_case_4(self):
        self.assertEqual(orderWords("Hello, World! How are you?"), "are Hello, How World! you?")

    def test_case_5(self):
        self.assertEqual(orderWords("I have 2 apples and 3 bananas!"), "2 3 and apples bananas! have I")


if __name__ == '__main__':
    unittest.main()
