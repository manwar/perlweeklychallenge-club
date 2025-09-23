#! /usr/bin/python3

def ascendingnumbers(a):
  prev = None
  for c in a.split(" "):
    try:
      n = int(c)
      if prev is not None and prev >= n:
        return False
      prev = n
    except ValueError:
      None
  return True
  
import unittest

class TestAscendingnumbers(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(ascendingnumbers("The cat has 3 kittens 7 toys 10 beds"), True, 'example 1')

  def test_ex2(self):
    self.assertEqual(ascendingnumbers("Alice bought 5 apples 2 oranges 9 bananas"), False, 'example 2')

  def test_ex3(self):
    self.assertEqual(ascendingnumbers("I ran 1 mile 2 days 3 weeks 4 months"), True, 'example 3')

  def test_ex4(self):
    self.assertEqual(ascendingnumbers("Bob has 10 cars 10 bikes"), False, 'example 4')

  def test_ex5(self):
    self.assertEqual(ascendingnumbers("Zero is 0 one is 1 two is 2"), True, 'example 5')

unittest.main()
