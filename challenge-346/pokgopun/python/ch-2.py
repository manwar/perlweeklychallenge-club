### https://theweeklychallenge.org/blog/perl-weekly-challenge-346/
"""

Task 2: Magic Expression

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string containing only digits and a target integer.

   Write a script to insert binary operators +, - and * between the digits
   in the given string that evaluates to target integer.

Example 1

Input: $str = "123", $target = 6
Output: ("1*2*3", "1+2+3")

Example 2

Input: $str = "105", $target = 5
Output: ("1*0+5", "10-5")

Example 3

Input: $str = "232", $target = 8
Output: ("2*3+2", "2+3*2")

Example 4

Input: $str = "1234", $target = 10
Output: ("1*2*3+4", "1+2+3+4")

Example 5

Input: $str = "1001", $target = 2
Output: ("1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1")
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 9th November
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def segCmb(n: int, l: int, tmp: list[int] = []):
    if n == 1:
        tmp.append(l)
        yield tmp
    else:
        for s in range(1,l):
            yield from segCmb(n-1, l-s, tmp+[s])

def segStr(seg: list[int], string: str) -> list[str]:
    strs: list[str] = []
    i = 0
    for n in seg:
        strs.append(string[i:i+n])
        i += n
    return strs

def me(string: str, target: int) -> set[str]:
    l = len(string)
    if l < 2:
        return set()
    ops = ('+','-','*')
    b = len(ops)
    res: set[str] = set()
    for n in range(2,l+1):
        for seg in segCmb(n, l):
            dgts = segStr(seg, string)
            if "".join(e.lstrip("0") if len(e) > 1 else e for e in dgts) != string:
                continue
            evl = [dgts[i//2] if i % 2 == 0 else ops[0] for i in range(2*len(dgts)-1)]
            for d in range(b**(n-1)):
                i = 2*n-1
                while d > 0:
                    i -= 2
                    evl[i] = ops[d%b]
                    d //= b
                while i > 1:
                    i -= 2
                    evl[i] = ops[0]
                evlstr = "".join(evl)
                if eval(evlstr) == target:
                    #print(evlstr)
                    res.add(evlstr)
    return res

import unittest

class TestMe(unittest.TestCase):
    def test(self):
        for (string, target), otpt in {
                ("123", 6): {"1*2*3", "1+2+3"},
                ("105", 5): {"1*0+5", "10-5"},
                ("232", 8): {"2*3+2", "2+3*2"},
                ("1234", 10): {"1*2*3+4", "1+2+3+4"},
                ("1001", 2): {"1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1"},
                #("1234567890", 1979): {'1+2*3+45*6*7-8+90','1+2-3+45*6*7+89-0','1+2-3+45*6*7+89+0'},
                #("12304560789", 8532): {'1*2*30+4*5*60*7+8*9'},
                }.items():
            self.assertEqual(me(string, target), otpt)

unittest.main()
