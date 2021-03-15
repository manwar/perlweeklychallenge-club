#!/usr/bin/env python

# Challenge 095
#
# TASK #2 › Demo Stack
# Submitted by: Mohammad S Anwar
# Write a script to demonstrate Stack operations like below:
#
# push($n) - add $n to the stack
# pop() - remove the top element
# top() - get the top element
# min() - return the minimum element
#
# Example:
# my $stack = Stack->new;
# $stack->push(2);
# $stack->push(-1);
# $stack->push(0);
# $stack->pop;       # removes 0
# print $stack->top; # prints -1
# $stack->push(0);
# print $stack->min; # prints -1

class Stack:
    def __init__(self):
        self.data = []
    def __repr__(self):
        return str(self.data)
    def push(self, n):
        self.data.append(n)
    def pop(self):
        self.data.pop()
    def top(self):
        return self.data[-1]
    def min(self):
        return min(self.data)

stack = Stack()
stack.push(2)
stack.push(-1)
stack.push(0)
stack.pop()         # removes 0
print(stack.top())  # prints -1
stack.push(0)
print(stack.min())  # prints -1
