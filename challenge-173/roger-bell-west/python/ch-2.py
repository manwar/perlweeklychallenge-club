#! /usr/bin/python3

import unittest

def sylvester(ct):
  o = [ 2 ]
  for i in range(2,ct+1):
    o.append(1 + (o[-1] * (o[-1] - 1)))
  return o

class TestSylvester(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(sylvester(10),[
            2,
            3,
            7,
            43,
            1807,
            3263443,
            10650056950807,
            113423713055421844361000443,
            12864938683278671740537145998360961546653259485195807,
            165506647324519964198468195444439180017513152706377497841851388766535868639572406808911988131737645185443
          ],'example 1')

unittest.main()
