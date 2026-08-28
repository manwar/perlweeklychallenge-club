#! /usr/bin/python3

def secretsanta(n):
  match n:
    case 0:
      return 1
    case 1:
      return 0
    case _:
      return (n - 1) * (secretsanta(n - 1) + secretsanta(n - 2))

import unittest

class TestSecretsanta(unittest.TestCase):

  def test_ex1(self):
    self.assertEqual(secretsanta(1), 0, 'example 1')

  def test_ex2(self):
    self.assertEqual(secretsanta(2), 1, 'example 2')

  def test_ex3(self):
    self.assertEqual(secretsanta(3), 2, 'example 3')

  def test_ex4(self):
    self.assertEqual(secretsanta(4), 9, 'example 4')

  def test_ex5(self):
    self.assertEqual(secretsanta(5), 44, 'example 5')

unittest.main()
