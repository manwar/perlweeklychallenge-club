#!/usr/bin/python3

# Challenge 013
#
# Challenge #2
# Write a script to demonstrate Mutually Recursive methods. Two methods are
# mutually recursive if the first method calls the second and the second calls
# first in turn. Using the mutually recursive methods, generate Hofstadter
# Female and Male sequences.
#
#  F ( 0 ) = 1   ;   M ( 0 ) = 0
#  F ( n ) = n - M ( F ( n - 1 ) ) , n > 0
#  M ( n ) = n - F ( M ( n - 1 ) ) , n > 0.

import sys

def F(n):
    if n==0:
        return 1
    else:
        return n-M(F(n-1))

def M(n):
    if n==0:
        return 0
    else:
        return n-F(M(n-1))

N = int(sys.argv[1])
print("F: "+", ".join([str(F(x)) for x in range(N)])+", ...")
print("M: "+", ".join([str(M(x)) for x in range(N)])+", ...")
