#! /usr/bin/python3
import unittest

def rw(n):
    t=n.split()
    t.reverse()
    return ' '.join(t)

class TestRw(unittest.TestCase):

    def test_ex1(self):
        self.assertEqual(rw('The Weekly Challenge'),'Challenge Weekly The','example 1');

    def test_ex2(self):
        self.assertEqual(rw('    Perl and   Raku are  part of the same family  '),'family same the of part are Raku and Perl','example 2');

unittest.main()
