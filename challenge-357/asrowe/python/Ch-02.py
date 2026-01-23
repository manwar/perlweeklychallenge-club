from itertools import product, groupby
from math import gcd
import unittest


def uniqueFractions(n: int) -> str:
    
    def candidateFractions(n):
        out = [i+1 for i in range(n)]
        out = product(out,out) #numerator and denominator        
        return out    
    
    def reduceFracs(fractions):
        pairs = sorted([(n//gcd(n,d),d//gcd(n,d)) for (n, d) in fractions], key=lambda pair: pair[0]/pair[1] )
        out = [k for k, g in groupby(pairs)] #Deduplicate
        return out
    
    def formatResult(fractions):
        return ", ".join([f"{pair[0]}/{pair[1]}" for pair in fractions])

    out = formatResult(reduceFracs(candidateFractions(n)))
    return out 


class ChallengeRunner(unittest.TestCase):

    def test_case_1(self):
        self.assertEqual(uniqueFractions(3), "1/3, 1/2, 2/3, 1/1, 3/2, 2/1, 3/1")

    def test_case_2(self):
        self.assertEqual(uniqueFractions(4), "1/4, 1/3, 1/2, 2/3, 3/4, 1/1, 4/3, 3/2, 2/1, 3/1, 4/1")

    def test_case_3(self):
        self.assertEqual(uniqueFractions(1), "1/1")

    def test_case_4(self):
        self.assertEqual(uniqueFractions(6), "1/6, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 5/6, 1/1, 6/5, 5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1, 6/1")

    def test_case_5(self):
        self.assertEqual(uniqueFractions(5), "1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1, 5/4, 4/3, 3/2, 5/3, 2/1, 5/2, 3/1, 4/1, 5/1")


if __name__ == '__main__':
    unittest.main()