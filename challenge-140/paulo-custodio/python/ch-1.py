#!/usr/bin/python3

# Challenge 140
#
# TASK #1 > Add Binary
# Submitted by: Mohammad S Anwar
# You are given two decimal-coded binary numbers, $a and $b.
#
# Write a script to simulate the addition of the given binary numbers.
#
# The script should simulate something like $a + $b. (operator overloading)
#
# Example 1
# Input: $a = 11; $b = 1;
# Output: 100
# Example 2
# Input: $a = 101; $b = 1;
# Output: 110
# Example 3
# Input: $a = 100; $b = 11;
# Output: 111

import sys

class Binary():
    def __init__(self, n):
        self.n = n

    def __str__(self):
        return str(self.n)

    def __add__(self, other):
        a = int(str(self.n), 2)
        b = int(str(other.n), 2)
        return Binary(int("{:b}".format(a+b)))

a = Binary(int(sys.argv[1]))
b = Binary(int(sys.argv[2]))
c = a+b
print(c)
