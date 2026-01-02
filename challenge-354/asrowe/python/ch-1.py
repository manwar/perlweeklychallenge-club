# Min Abs Difference
'''
    Rules (a,b):
    1: a, b are from the given array.
    2: a < b
    3: b - a = min abs diff any two elements in the given array

   Input: @ints= (4, 2, 1, 3)
   Output: [1, 2], [2, 3], [3, 4] 

   Input: @ints = (10, 100, 20, 30)
   Output: [10, 20], [20, 30]

   Input: @ints = (-5, -2, 0, 3)
   Output: [-2, 0]

   Input: @ints = (8, 1, 15, 3)
   Output: [1, 3]

   Input: @ints = (12, 5, 9, 1, 15)
   Output: [9, 12], [12, 15] 
'''
import unittest
from itertools import combinations

def mad(nums: tuple) -> list:
    combs = list(combinations(sorted(nums), 2))
    mad = min([abs(b-a) for a,b in combs])
    out = [[a, b] for a,b in combs if abs(b-a) == mad]
    return out
    


class ChallengeRunner(unittest.TestCase):
    def test_ex_1(self):
        self.assertEqual(mad((4, 2, 1, 3)), [[1, 2], [2, 3], [3, 4]])

    def test_ex_2(self):
        self.assertEqual(mad((10, 100, 20, 30)), [[10, 20], [20, 30]])

    def test_ex_3(self):
        self.assertEqual(mad((-5, -2, 0, 3)), [[-2, 0]])

    def test_ex_4(self):
        self.assertEqual(mad((8, 1, 15, 3)), [[1, 3]])

    def test_ex_5(self):
        self.assertEqual(mad((12, 5, 9, 1, 15)), [[9, 12], [12, 15]])

if __name__ == '__main__':
    unittest.main()
    