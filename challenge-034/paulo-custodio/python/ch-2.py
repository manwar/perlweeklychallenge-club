#!/usr/bin/python3

# Challenge 034
#
# Task #2
# Contributed by Dave Cross
# Write a program that demonstrates a dispatch table.

import sys

# simple rpn calculator
stack = []
def add():
    b = stack.pop()
    a = stack.pop()
    stack.append(a+b)

def sub():
    b = stack.pop()
    a = stack.pop()
    stack.append(a-b)

def mul():
    b = stack.pop()
    a = stack.pop()
    stack.append(a*b)

def div():
    b = stack.pop()
    a = stack.pop()
    stack.append(a/b)

def prt():
    print(stack.pop())

dispatch = {'+': add, '-':sub, '*':mul, '/':div, '.':prt}

prog = "".join(sys.argv[1:])
for c in prog:
    if c.isspace():
        pass
    elif c.isdigit():
        stack.append(int(c))
    else:
        dispatch[c]()
