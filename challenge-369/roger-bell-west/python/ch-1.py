#! /usr/bin/python3

def validtag(a):
  p = "#"
  up = False
  for c in a:
    if c.isalpha():
      cc = c
      if up:
        cc = cc.upper()
        up = False
      else:
        cc = cc.lower()
      p += cc
    elif c == " " and len(p) > 1:
      up = True
  if len(p) > 100:
    p = p[0:100]
  return p

import unittest

class TestValidtag(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(validtag("Cooking with 5 ingredients!"), "#cookingWithIngredients", 'example 1')

  def test_ex2(self):
    self.assertEqual(validtag("the-last-of-the-mohicans"), "#thelastofthemohicans", 'example 2')

  def test_ex3(self):
    self.assertEqual(validtag("  extra spaces here"), "#extraSpacesHere", 'example 3')

  def test_ex4(self):
    self.assertEqual(validtag("iPhone 15 Pro Max Review"), "#iphoneProMaxReview", 'example 4')

  def test_ex5(self):
    self.assertEqual(validtag("Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"), "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn", 'example 5')

unittest.main()
