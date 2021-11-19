#!/usr/bin/python3

# Challenge 017
#
# Task #1
# Create a script to demonstrate Ackermann function. The Ackermann function is
# defined as below, m and n are positive number:
#
#   A(m, n) = n + 1                  if m = 0
#   A(m, n) = A(m - 1, 1)            if m > 0 and n = 0
#   A(m, n) = A(m - 1, A(m, n - 1))  if m > 0 and n > 0
#
# Example expansions as shown in wiki page.
#
#  A(1, 2) = A(0, A(1, 1))
#          = A(0, A(0, A(1, 0)))
#          = A(0, A(0, A(0, 1)))
#          = A(0, A(0, 2))
#          = A(0, 3)
#          = 4

import sys

def A(m, n):
    if m==0:
        return n+1
    elif m>0 and n==0:
        return A(m-1, 1)
    elif m>0 and n>0:
        return A(m-1, A(m, n-1))

print(A(*[int(x) for x in sys.argv[1:3]]))
