import unittest

def isMountainArray(ints:list) -> bool:
    # the list follows a mountain array pattern if it
    # 1) splits into two segments, 
    #   - one strictly accending
    #   - one strinctly decending

    def labelDifference(a,b):
        if a < b:
            return 'acc'
        elif a > b:
            return 'dec'
        else:
            return 'eq'

    def splitByConstantTrajectory(ints:list):
        out = []
        differences = [labelDifference(i,j) for i, j in zip(ints[:-1], ints[1:])]
         
        prev = None
        for cur in differences: 
            if cur is not prev:
                out.append(cur)
            prev = cur
                              
        return out

    segments = splitByConstantTrajectory(ints)   
    return  len(segments) == 2 and segments[0] is 'acc' and segments[1] is 'dec'


class ChallengeRunner(unittest.TestCase):

    def test_example_01(self):
        self.assertEqual(isMountainArray([1, 2, 3, 4, 5]), False)

    def test_example_02(self):
        self.assertEqual(isMountainArray([0, 2, 4, 6, 4, 2, 0]), True)

    def test_example_03(self):
        self.assertEqual(isMountainArray([5, 4, 3, 2, 1]), False )

    def test_example_04(self):
        self.assertEqual(isMountainArray([1, 3, 5, 5, 4, 2]), False)

    def test_example_05(self):
        self.assertEqual(isMountainArray([1, 3, 2]), True )

if __name__ == '__main__':
    unittest.main()