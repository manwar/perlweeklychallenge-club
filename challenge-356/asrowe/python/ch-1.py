import unittest
from itertools import groupby

#Task 1: i Sequence


# You are given an integer, $int > 3.

# Write a script to generate the kolakoskii Sequence of given length $int and return the count of 1 in 
# the generated sequence. Please follow the wikipedia page for more informations.

# Example 1
# Input: $int = 4

example_1_out = (2, "(1)(22)(11)(2) => 1221")

# Example 2
# Input: $int = 5
# Output: 3

# (1)(22)(11)(2)(1) => 12211

example_2_out = (3, "(1)(22)(11)(2)(1) => 12211")


# Example 3
# Input: $int = 6
# Output: 3

# (1)(22)(11)(2)(1)(22) => 122112

example_3_out = (3, "(1)(22)(11)(2)(1)(22) => 122112")


# Example 4
# Input: $int = 7
# Output: 4

# (1)(22)(11)(2)(1)(22)(1) => 1221121

example_4_out = (4, "(1)(22)(11)(2)(1)(22)(1) => 1221121")


# Example 5
# Input: $int = 8
# Output: 4

# (1)(22)(11)(2)(1)(22)(1)(22) => 12211212

example_5_out = (4, "(1)(22)(11)(2)(1)(22)(1)(22) => 12211212")




def runLengthEncode(ns:list) -> list:
    return [sum(1 for _ in y) for _, y in groupby(ns)]


def kolakoski(n:int) -> list:
    
    outSeq = [1, 2, 2]
    for i in range(3, n+1):
        symbol = 1 if i %2 == 1 else 2
        block = [symbol for _ in range(outSeq[i-1])]
        
        outSeq += block

    return outSeq


def kolakoski_challenge(n:int) -> int:
    k = kolakoski(n)
    rle = runLengthEncode(k)
    out = sum([1 for x in rle if x ==1])
    return out


class ChallengeRunner(unittest.TestCase):

    def test_example_01(self):
        self.assertEqual(kolakoski_challenge(4), example_1_out[0])

    def test_example_02(self):
        self.assertEqual(kolakoski_challenge(5), example_2_out[0])

    def test_example_03(self):
        self.assertEqual(kolakoski_challenge(6), example_3_out[0])

    def test_example_04(self):
        self.assertEqual(kolakoski_challenge(7), example_4_out[0])

    def test_example_05(self):
        self.assertEqual(kolakoski_challenge(8), example_5_out[0])


if __name__ == '__main__':
    unittest.main()