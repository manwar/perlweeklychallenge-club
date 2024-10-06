### https://theweeklychallenge.org/blog/perl-weekly-challenge-288/
"""

Task 1: Closest Palindrome

Submitted by: [49]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str, which is an integer.

   Write a script to find out the closest palindrome, not including
   itself. If there are more than one then return the smallest.

     The closest is defined as the absolute difference minimized between
     two integers.

Example 1

Input: $str = "123"
Output: "121"

Example 2

Input: $str = "2"
Output: "1"

There are two closest palindrome "1" and "3". Therefore we return the smallest "
1".

Example 3

Input: $str = "1400"
Output: "1441"

Example 4

Input: $str = "1001"
Output: "999"

Task 2: Contiguous Block
"""
### solution by pokgopun@gmail.com

#from typing import List, Self ### required python3.11 or greater
from typing import List,TypeAlias
from typing_extensions import Self ### this is 3rd party library that needs pip install

Digit: TypeAlias = List[int]

class Palindrome:
    def __init__(self, numstr: str):
        self.dgt: Digit = []
        self.d0d = False
        if numstr.isdigit() and strIsPalindrome(numstr):
            l = len(str(int(numstr)))
            self.dgt = [ord(e)-48 for e in tuple(numstr[l//2:])]
            self.d0d = l%2==0
    def __str__(self) -> str:
        if len(self.dgt) == 0:
            return ""
        str0 = str(self.dgt[0])
        if self.d0d:
            str0 += str0 
        for n in self.dgt[1:]:
            str0 = str(n) + str0 + str(n)
        return str0
    def num(self) -> int:
        str0 = self.__str__()
        if len(str0) > 0:
            return int(str0)
        return -1
    def next(self) -> Self:
        l = len(self.dgt)
        if l == 0:
            return self
        self.dgt = num2dgt(dgt2num(self.dgt)+1)
        if len(self.dgt) > l:
            if self.d0d==False:
                self.dgt = self.dgt[1:]
            self.d0d = not self.d0d
        return self
    def prev(self) -> Self:
        n = dgt2num(self.dgt)
        if n < 0:
            return self
        if n == 0:
            self.dgt = self.dgt[1:]
        if n == 1 and self.d0d == True:
            self.dgt[0] = 9
            self.d0d = False
        elif n < 10:
            self.dgt[0] = n - 1
        else:
            l = len(self.dgt)
            self.dgt = num2dgt(n - 1)
            if len(self.dgt) < l:
                if self.d0d == True:
                    self.dgt = num2dgt(n*10 - 1)
                self.d0d = not self.d0d
        return self

def dgt2num(ints: Digit) -> int:
    if len(ints) == 0:
        return -1
    return int("".join(chr(e+48) for e in reversed(ints)))

def num2dgt(num: int) -> Digit:
    if num < 0:
        return []
    return [ord(e)-48 for e in reversed(str(num))]
    
def strIsPalindrome(string: str) -> bool:
    return string=="".join(reversed(string))

def closestPalindrome(numstr: str) -> str:
    if not numstr.isdigit():
        return ""
    n = int(numstr)
    if n == 0:
        return "1"
    elif n < 10:
        return str(n-1)
    if strIsPalindrome(numstr):
        p0 = Palindrome(numstr).prev()
        p2 = Palindrome(numstr).next()
        if p2.num() - n < n - p0.num():
            return p2.__str__()
        return p0.__str__()
    numstr = str(n)
    l = len(numstr)
    h = numstr[:l//2]
    #print("numstr=>",numstr,"h=>",h)
    if l%2==0:
        numstr = h
    else:
        numstr = h + numstr[l//2]
    numstr += "".join(reversed(h))
    #print("numstr->",numstr)
    p1 = Palindrome(numstr)
    num1 = p1.num()
    diff1 = num1 - n
    if diff1 > 0:
        p2 = Palindrome(numstr).prev()
        num2 = p2.num()
        diff2 = n - num2
    else:
        diff1 *= -1
        p2 = Palindrome(numstr).next()
        num2 = p2.num()
        diff2 = num2 - n
    if diff1 == diff2:
        return str(min(num1,num2))
    if diff1 < diff2:
        return num1.__str__()
    else:
        return num2.__str__()

import unittest

class TestClosestPanlindrome(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "123": "121",
                "2": "1",
                "1400": "1441",
                "1001": "999",
                "0":"1",
                "10":"9",
                "16": "11",
                "17": "22",
                "44500":"44544",
                "44499":"44544",
                "446000":"445544",
                "444099":"444444",
                "99049":"99099",
                "99039":"98989",
                "990649":"990099",
                "99994499":"99988999",
                "99999994499999":"99999988999999",
                "99999983599999":"99999988999999",
                "9999999999999999":"10000000000000001",
                "9999999889999999":"9999999779999999",
                "9999999834999999":"9999999779999999",
                "9999999835000000":"9999999889999999",
                }.items():
            self.assertEqual(closestPalindrome(inpt),otpt)

unittest.main()
