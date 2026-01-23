import unittest
from typing import Iterable

def intToList(i:int) -> list:
    out = [int(d) for d in str(i)]
    return out

def listToInt(l:Iterable) -> int:
    out = int("".join(map(str,l)))
    return out

def fillZeros(l, length):
    return [0 for _ in range(length - len(l))] + l

def convergeToKaprekar(x :int, verbose=False) -> int:
    
    def converged(k: int) -> bool:
        return k == 6174

    def formatTrace(i, trace) -> str:
        return f"Iteration {i}: {trace[0]:04} - {trace[1]:04} = {trace[2]:04}"

    i = 0
    trace = []

    while not converged(x) and i<=10:
        digits = fillZeros(intToList(x),4)
        a = sorted(digits)
        d = listToInt(reversed(a))
        a = listToInt(a)

        higher,lower = (a,d) if a >= d else (d,a)
        x = higher-lower
        
        if x == 0:
            return -1
        
        if verbose:
            print(formatTrace(i,(higher,lower,x)))        

        i += 1    

    out = i
    return out


class ChallengeRunner(unittest.TestCase):

    def test_case_1(self):
        self.assertEqual(convergeToKaprekar(3524), 3)

    def test_case_2(self):
        self.assertEqual(convergeToKaprekar(6174), 0)

    def test_case_3(self):
        self.assertEqual(convergeToKaprekar(9998), 5)

    def test_case_4(self):
        self.assertEqual(convergeToKaprekar(1001), 4)

    def test_case_5(self):
        self.assertEqual(convergeToKaprekar(9000), 4)

    def test_case_6(self):
        self.assertEqual(convergeToKaprekar(1111), -1)


if __name__ == '__main__':
    unittest.main()
