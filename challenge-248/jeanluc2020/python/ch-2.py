#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-248/#TASK2
#
# Task 2: Submatrix Sum
# =====================
#
# You are given a NxM matrix A of integers.
#
# Write a script to construct a (N-1)x(M-1) matrix B having elements that are
# the sum over the 2x2 submatrices of A,
#
# b[i,k] = a[i,k] + a[i,k+1] + a[i+1,k] + a[i+1,k+1]
#
# 
## Example 1
##
## Input: $a = [
##               [1,  2,  3,  4],
##               [5,  6,  7,  8],
##               [9, 10, 11, 12]
##             ]
##
## Output: $b = [
##                [14, 18, 22],
##                [30, 34, 38]
##              ]
#
## Example 2
##
## Input: $a = [
##               [1, 0, 0, 0],
##               [0, 1, 0, 0],
##               [0, 0, 1, 0],
##               [0, 0, 0, 1]
##             ]
##
## Output: $b = [
##                [2, 1, 0],
##                [1, 2, 1],
##                [0, 1, 2]
##              ]
#
############################################################
##
## discussion
##
############################################################
#
# Just some index arithmetic

def submatrix_sum(matrix: list) -> list:
    print("Input: [")
    for array in matrix:
        print("        [", ",".join([str(x) for x in array]), "],")
    print("       ]")
    l = len(matrix)
    m = len(matrix[0])
    resultmatrix = []
    for i in range(l-1):
        resultmatrix.append([])
        for k in range(m-1):
            resultmatrix[i].append( matrix[i][k] + matrix[i][k+1] + matrix[i+1][k] + matrix[i+1][k+1] )
    print("Output: [")
    for array in resultmatrix:
        print("         [", ",".join([str(x) for x in array]), "],")
    print("        ]")
    return resultmatrix

submatrix_sum( [ [1,  2,  3,  4], [5,  6,  7,  8], [9, 10, 11, 12] ] )
submatrix_sum( [ [1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1] ] )

