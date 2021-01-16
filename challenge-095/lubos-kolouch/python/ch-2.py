#!env python
"""
# ===============================================================================
#
#         FILE: ch_2.py
#
#        USAGE: ./ch_2.py
#
#  DESCRIPTION: Perl Weekly Challenge #095
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-095/
#               Demo Stack
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 01/13/2021 02:39:16 PM
#===============================================================================
"""


class Stack:
    """ Class to the stack """

    def __init__(self):
        self.stack = []

    def push(self, value: int):
        """ Demostrate push """
        self.stack.insert(0, value)

    @property
    def pop(self):
        """ Demonstrate pop """

        try:
            return self.stack.pop(0)
        except IndexError:
            return None

    @property
    def top(self):
        """ Demonstrate top """

        return self.stack[0]

    @property
    def stack_min(self):
        """ Demostrate min """

        return min(self.stack)


def test_cases():
    """ Test cases """

    stack = Stack()
    assert stack.pop == None

    stack.push(2)
    assert stack.top == 2

    stack.push(-1)
    assert stack.top == -1

    stack.push(0)
    assert stack.top == 0

    assert stack.pop == 0
    assert stack.top == -1

    stack.push(0)
    assert stack.stack_min == -1
