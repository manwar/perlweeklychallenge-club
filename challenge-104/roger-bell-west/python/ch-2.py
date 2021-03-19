#! /usr/bin/python3

import sys
from random import randint

def note(*a):
    print(*a, file = sys.stderr)

def game(hh=12):
    heap=hh
    players=["Alice","Bob"]
    a=0
    while heap>0:
        n=play(heap)
        heap -= n
        note("{:s} takes {:d} leaving {:d}".format(players[a],n,heap))
        if heap==0:
            note("{:s} wins".format(players[a]))
            break
        a += 1
        a %= 2
    return a

def play(state):
    m=state % 4
    if m==0:
        return randint(1,3)
    else:
        return m

import unittest

class TestNim(unittest.TestCase):

        def test_ex1(self):
            self.assertEqual(game(),1,'example 1')
                         
        def test_ex2(self):
            self.assertEqual(game(10),0,'example 2')
                                          
        def test_ex3(self):
            self.assertEqual(game(14),0,'example 3')

unittest.main()
