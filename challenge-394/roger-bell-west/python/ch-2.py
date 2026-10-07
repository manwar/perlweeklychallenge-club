#! /usr/bin/python3

def common_substring(a0):
  a = a0.copy()
  a.sort(key = len)
  results = []
  for l in reversed(range(1, len(a[0]))):
    for offset in range(len(a[0]) - l + 1):
      m = True
      sample = a[0][offset:offset + l]
      for axi in range(1, len(a)):
        if a[axi].find(sample) == -1:
          m = False
          break
      if m:
        results.append(sample)
      # for longest common substring only:
      # if len(results) > 0:
      #   break
  return results

def is_avc(a):
  valid = True
  laststate = False
  for i, c in enumerate(a):
    match(c):
      case 'a' | 'e' | 'i' | 'o' | 'u':
        thisstate = True
      case _:
        thisstate = False
    if i > 0 and thisstate == laststate:
      valid = False
      break
    laststate = thisstate
  return valid

def alternatingvowelsconsonants(a):
  candidates = common_substring(a)
  c2 = [w for w in candidates if is_avc(w)]
  if len(c2) > 0:
    l = len(c2[0])
    return [w for w in c2 if len(w) == l]
  else:
    return []

import unittest

class TestAlternatingvowelsconsonants(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(alternatingvowelsconsonants(["relocate", "delocate", "allocate"]), ["locate"], 'example 1')

  def test_ex2(self):
    self.assertEqual(alternatingvowelsconsonants(["apple", "banana", "cherry"]), [], 'example 2')

  def test_ex3(self):
    self.assertEqual(alternatingvowelsconsonants(["navigate", "cavity", "gravity"]), ["avi"], 'example 3')

  def test_ex4(self):
    self.assertEqual(alternatingvowelsconsonants(["pedalgia", "pedalboard", "pedantic"]), ["peda"], 'example 4')

  def test_ex5(self):
    self.assertEqual(alternatingvowelsconsonants(["schoolmaster", "schoolhouse", "schooling"]), ["ho", "ol"], 'example 5')

unittest.main()
