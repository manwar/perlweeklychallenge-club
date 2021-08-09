#!/usr/bin/env python

import sys

def lr(tree):
    if (len(tree) < 3 or tree[0] == '.'):
        return [[],[]]
    if len(tree) == 3:
        return [["."],["."]]
    left=[]
    sm,ix = 0,1
    while sm != -1: 
        left.append(tree[ix])
        sm+=(-1 if tree[ix] == '.' else 1)
        ix+=1
    right = tree[len(left)+1:]
    return [left,right]

def lrLongPath(tree):
    if tree[0] == '.':
        return [[],[]]
    if len(tree) == 3:
        return [[tree[0]],[tree[0]]]
    left,right = lr(tree)
    lLongPath = [tree[0]] + max(lrLongPath(left), key=len)
    rLongPath = [tree[0]] + max(lrLongPath(right), key=len)
    return [lLongPath,rLongPath]

def biLongPath(tree):
    if len(tree) < 3 or tree[0] == '.':
        return []
    if len(tree) == 3:
        return [tree[0]]
    lPath,rPath = lrLongPath(tree)
    path = list(reversed(lPath[1:])) + rPath
    left,right = lr(tree)
    return max([path]+list(map(biLongPath, [left,right])), key=len)

print(" ".join(biLongPath(sys.argv[1:])))

"""
run <script> <tree in preorder form with '.' for empty nodes, entered as space-separated values>

ref: https://stackoverflow.com/a/2676849/11064961

e.g. 1 2 4 . 7 . . . 3 5 . . 6 . . represents the tree

        1
       / \
      2   3
     /   / \
    4   5   6
     \
      7

given as an example in the problem formulation at https://perlweeklychallenge.org/blog/perl-weekly-challenge-113/#TASK2
"""
