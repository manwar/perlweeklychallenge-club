

import unittest
from itertools import groupby

def strReduce(word: str, verbose=False) -> str:
    def groupChars(word):
        groups = []
        head = ''

        for c in word:
            if head == '' or head[-1] == c:
                head += c
            else:
                groups.append(head);
                head = c
        groups.append(head)
        
        return groups


    
    fixed = False
    in_word = word
    reduced = None
    
    while not fixed:
        reduced = "".join([g for g in groupChars(in_word) if len(g) == 1])
        if reduced == in_word:
            fixed = True
        else:
            in_word = reduced
    return reduced




class ChallengeRunner(unittest.TestCase):

    def test_case_1(self):
        self.assertEqual(strReduce("aabbccdd"), "")

    def test_case_2(self):
        self.assertEqual(strReduce("abccba"), "")

    def test_case_3(self):
        self.assertEqual(strReduce("abcdef"), "abcdef")

    def test_case_4(self):
        self.assertEqual(strReduce("aabbaeaccdd"), "aea")

    def test_case_5(self):
        self.assertEqual(strReduce("mississippi"), "m")


if __name__ == '__main__':
    unittest.main()