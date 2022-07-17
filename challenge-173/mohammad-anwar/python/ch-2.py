#!/usr/bin/python3

'''

Week 173:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-173

Task #2: Sylvester’s sequence

    Write a script to generate first 10 members of Sylvester's sequence.

'''

import unittest

def SylvesterSequence(n):
    ss = [2]
    for i in range (1, --n):
        ss.append(1 + ss[-1] * (ss[-1] - 1))
    return ss

#
#
# Unit test class

class TestSylvesterSequence(unittest.TestCase):

    def test_example(self):
        self.assertEqual(SylvesterSequence(10),
        [
          2
         ,3
         ,7
         ,43
         ,1807
         ,3263443
         ,10650056950807
         ,113423713055421844361000443
         ,12864938683278671740537145998360961546653259485195807
         ,165506647324519964198468195444439180017513152706377497841851388766535868639572406808911988131737645185443
       ])

unittest.main()
