#!/usr/bin/env python3

# Challenge 039
#
# TASK #2
# Contributed by Andrezgz
# Write a script to demonstrate Reverse Polish notation(RPN). Checkout the wiki
# page for more information about RPN.

import sys

# simple rpn calculator
stack = []

def rpn(op):
    if op.isdigit():
        stack.append(int(op))
    elif op == '+':
        b = stack.pop()
        a = stack.pop()
        stack.append(a+b)
    elif op == '-':
        b = stack.pop()
        a = stack.pop()
        stack.append(a-b)
    elif op == '*':
        b = stack.pop()
        a = stack.pop()
        stack.append(a*b)
    elif op == '/':
        b = stack.pop()
        a = stack.pop()
        stack.append(a/b)
    elif op == '.':
        a = stack.pop()
        print(a)
    elif op.isspace():
        pass
    else:
        print("invalid operation:", op)

for c in "".join(sys.argv[1:]):
    rpn(c)
