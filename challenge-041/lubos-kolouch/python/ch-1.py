#!python3

import sys
from sympy.ntheory import factorint, isprime
import unittest

def is_attractive(what):
    factors = factorint(int(what))
    return (isprime(sum(factors.values())))


# TESTS

class PrimeTest(unittest.TestCase):
    def test_20(self):
        self.assertEqual(is_attractive(20),True)
    def test_128(self):
        self.assertEqual(is_attractive(128),True)
    def test_256(self):
        self.assertEqual(is_attractive(256),False)

if __name__ == "__main__":
    unittest.main()

