# The Weekly Challenge 163
# Task 2 Summation
# Python script
# Usage: $ python3 ch-2.py [parameter]


import unittest
import sys


def compute(array):
    NUM = len(array)
    v = array
    new_v = []
    for r in range(1, NUM):
        new_v = []
        new_v.append(v[1])
        for nxt in range(1, NUM-r):
            new_v.append(new_v[nxt-1] + v[nxt+1])
        v = new_v
    return new_v[0]

class SimpleTest(unittest.TestCase):
    def test_example(self):
        self.assertEqual(compute([1,2,3,4,5]), 42)
        self.assertEqual(compute([1,3,5,7,9]), 70)


if __name__ == "__main__":
    myArr = []
    if len(sys.argv) > 1:
        for i in range(1, len(sys.argv)):
            myArr.append(int(sys.argv[i]))
        ans = compute(myArr)
        print(ans)
    else:
        unittest.main()
