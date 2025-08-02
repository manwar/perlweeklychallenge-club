### https://theweeklychallenge.org/blog/perl-weekly-challenge-266/
"""

Task 1: Uncommon Words

Submitted by: [41]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two sentences, $line1 and $line2.

   Write a script to find all uncommmon words in any order in the given
   two sentences. Return ('') if none found.

     A word is uncommon if it appears exactly once in one of the
     sentences and doesn’t appear in other sentence.

Example 1

Input: $line1 = 'Mango is sweet'
       $line2 = 'Mango is sour'
Output: ('sweet', 'sour')

Example 2

Input: $line1 = 'Mango Mango'
       $line2 = 'Orange'
Output: ('Orange')

Example 3

Input: $line1 = 'Mango is Mango'
       $line2 = 'Orange is Orange'
Output: ('')

Task 2: X Matrix
"""
### solution by pokgopun@gmail.com

def uncommonWords(line1, line2):
    words = f'{line1} {line2}'.split()
    return tuple(
            w for w in words if words.count(w)==1
            ) or ('',)


import unittest

class TestUncommonWords(unittest.TestCase):
    def test(self):
        for (line1,line2), ans in {
                ('Mango is sweet','Mango is sour'): ('sweet', 'sour'),
                ('Mango Mango','Orange'): ('Orange',),
                ('Mango is Mango','Orange is Orange'): ('',),
                }.items():
            self.assertEqual(uncommonWords(line1,line2),ans)

unittest.main()
