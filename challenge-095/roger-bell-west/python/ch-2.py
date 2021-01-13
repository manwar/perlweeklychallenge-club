#! /usr/bin/python3
import unittest

class Stack:

    def __init__(self):
        self.stack=list()

    def push(self,op):
        self.stack.append(op)

    def pop(self):
        if len(self.stack)==0:
            raise Exception("Insufficient elements for pop")
        return self.stack.pop()

    def top(self):
        if len(self.stack)==0:
            raise Exception("Insufficient elements for top")
        return self.stack[len(self.stack)-1]

    def min(self):
        if len(self.stack)==0:
            raise Exception("Insufficient elements for min")
        return min(self.stack)

class TestStack(unittest.TestCase):

    def test_ex1(self):
        stack=Stack()
        stack.push(2)
        stack.push(-1)
        stack.push(0)
        self.assertEqual(stack.pop(),0,'example 1')

    def test_ex2(self):
        stack=Stack()
        stack.push(2)
        stack.push(-1)
        stack.push(0)
        stack.pop()
        self.assertEqual(stack.top(),-1,'example 2')

    def test_ex3(self):
        stack=Stack()
        stack.push(2)
        stack.push(-1)
        stack.push(0)
        stack.pop()
        stack.push(0)
        self.assertEqual(stack.min(),-1,'example 3')

unittest.main()
