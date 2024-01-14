### https://theweeklychallenge.org/blog/perl-weekly-challenge-251/
"""

Task 1: Concatenation Value

Submitted by: [52]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find the concatenation value of the given array.

   The concatenation of two numbers is the number formed by concatenating
   their numerals.
For example, the concatenation of 10, 21 is 1021.
The concatenation value of @ints is initially equal to 0.
Perform this operation until @ints becomes empty:

If there exists more than one number in @ints, pick the first element
and last element in @ints respectively and add the value of their
concatenation to the concatenation value of @ints, then delete the
first and last element from @ints.

If one element exists, add its value to the concatenation value of
@ints, then delete it.

Example 1

Input: @ints = (6, 12, 25, 1)
Output: 1286

1st operation: concatenation of 6 and 1 is 61
2nd operation: concaternation of 12 and 25 is 1225

Concatenation Value => 61 + 1225 => 1286

Example 2

Input: @ints = (10, 7, 31, 5, 2, 2)
Output: 489

1st operation: concatenation of 10 and 2 is 102
2nd operation: concatenation of 7 and 2 is 72
3rd operation: concatenation of 31 and 5 is 315

Concatenation Value => 102 + 72 + 315 => 489

Example 3

Input: @ints = (1, 2, 10)
Output: 112

1st operation: concatenation of 1 and 10 is 110
2nd operation: only element left is 2

Concatenation Value => 110 + 2 => 112

Task 2: Lucky Numbers
"""
### solution by pokgopun@gmail.com

def concatenation(tup: tuple):
    #print(tup)
    l = len(tup)
    sum = 0
    for i in range(l//2):
        #print(tup[i],tup[l-1-i],"=>",int(str(tup[i])+str(tup[l-1-i])))
        sum += int(str(tup[i])+str(tup[l-1-i]))
    if l % 2:
        #print("addition",tup[l//2])
        sum += tup[l//2]
    return sum

import unittest

class TestConcatenation(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                (6, 12, 25, 1): 1286,
                (10, 7, 31, 5, 2, 2): 489,
                (1, 2, 10): 112,
                }.items():
            self.assertEqual(concatenation(inpt),otpt)

unittest.main()



