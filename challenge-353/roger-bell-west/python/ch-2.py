#! /usr/bin/python3

import re

def validatecoupon(codes, names, status):
  rx = re.compile(r"^[0-9A-Za-z_]+$")
  dep = set(n for n in ["electronics", "grocery", "pharmacy", "restaurant"])
  return [bool(re.match(rx, codes[i])) and names[i] in dep and status[i] for i in range(len(codes))]

import unittest

class TestValidatecoupon(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(validatecoupon(["A123", "B_456", "C789", "D@1", "E123"], ["electronics", "restaurant", "electronics", "pharmacy", "grocery"], [True, False, True, True, True]), [True, False, True, False, True], 'example 1')

  def test_ex2(self):
    self.assertEqual(validatecoupon(["Z_9", "AB_12", "G01", "X99", "test"], ["pharmacy", "electronics", "grocery", "electronics", "unknown"], [True, True, False, True, True]), [True, True, False, True, False], 'example 2')

  def test_ex3(self):
    self.assertEqual(validatecoupon(["_123", "123", "", "Coupon_A", "Alpha"], ["restaurant", "electronics", "electronics", "pharmacy", "grocery"], [True, True, False, True, True]), [True, True, False, True, True], 'example 3')

  def test_ex4(self):
    self.assertEqual(validatecoupon(["ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"], ["electronics", "electronics", "grocery", "grocery"], [True, True, True, True]), [True, True, True, True], 'example 4')

  def test_ex5(self):
    self.assertEqual(validatecoupon(["CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"], ["restaurant", "electronics", "grocery", "pharmacy", "electronics"], [True, True, True, True, False]), [True, True, True, True, False], 'example 5')

unittest.main()
