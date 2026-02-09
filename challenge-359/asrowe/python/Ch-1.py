
import unittest

def digitalRoot(i:int) -> tuple:
    
    def digitalRoot(i:int, depth:int)-> tuple:
        if i < 10:
            return (i, depth)
        else:
            digit_sum = sum((int(c) for c in str(i)))
            return digitalRoot(digit_sum, depth+1)
    
    out = digitalRoot(i, 0)
    return out

def dev():
    for num in [38, 7, 999, 1999999999, 101010]:
        dr, p = digitalRoot(num)
        print(f"Persistance  = {p}\nDigital Root = {dr}\n")


class ChallengeRunner(unittest.TestCase):

    def test_case_1(self):
        self.assertEqual(digitalRoot(38), (2,2))

    def test_case_2(self):
        self.assertEqual(digitalRoot(7), (7,0))

    def test_case_3(self):
        self.assertEqual(digitalRoot(999), (9,2))

    def test_case_4(self):
        self.assertEqual(digitalRoot(1999999999), (1,3))

    def test_case_5(self):
        self.assertEqual(digitalRoot(101010), (3,1))



if __name__ == '__main__':
    #dev()
    unittest.main()