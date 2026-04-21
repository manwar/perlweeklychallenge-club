
## Ref.
## By AI

from functools import cache
from collections import Counter

class Solution:
    @cache
    def IsScramble(self, strInput_01, strInput_02):
        ## Base case: Identical strings
        if strInput_01 == strInput_02:
            return True
        
        ## Pruning: Must be anagrams to be a scramble
        if Counter(strInput_01) != Counter(strInput_02):
            return False
        
        nLen = len(strInput_01)
        for nIndx in range(1, nLen):
            ## Case 1: No Swap At This Split Point
            if self.IsScramble(strInput_01[:nIndx], strInput_02[:nIndx]) and self.IsScramble(strInput_01[nIndx:], strInput_02[nIndx:]):
                return True
            
            ## Case 2: Swap Occurred At This Split Point
            if self.IsScramble(strInput_01[:nIndx], strInput_02[nLen - nIndx:]) and self.IsScramble(strInput_01[nIndx:], strInput_02[:nLen - nIndx]):
                return True

        return False

## Example 1
## strWord_01 = "abc"
## strWord_02 = "acb"

## Example 2
## strWord_01 = "abcd"
## strWord_02 = "cdba"

## Example 3
## strWord_01 = "hello"
## strWord_02 = "hiiii"

## Example 4
## strWord_01 = "ateer"
## strWord_02 = "eater"

## Example 5
strWord_01 = "abcd"
strWord_02 = "bdac"

objMyWord = Solution()

print (objMyWord.IsScramble(strWord_01, strWord_02))
