#!/usr/bin/env python

import sys
from print_tree import print_tree

class Node(object):
    def __init__(self, value):
        self.value = value
        self.children = []

class print_custom_tree(print_tree):
    def get_children(self, node):
        return node.children
    def get_node_str(self, node):
        return str(node.value)

def moreDots(lst):
    return lambda i: 2*len(list(filter(lambda x: x == ".",lst[1:i+1]))) > i
    
def list2node(lst):
    if len(lst) == 0 or lst[0] == '.':
        return Node("")
    ix = next(filter(moreDots(lst), range(0,len(lst))))
    root=Node(lst[0])
    lft=list2node(lst[1:ix+1])
    rght=list2node(lst[ix+1:])
    root.children=[lft,rght]
    return root
    
INPUT = sys.argv[1:] if len(sys.argv) >= 2 else ["1", "2", "4", ".", "7", ".", ".", ".", "3", "5", ".", ".", "6", ".", "."]
sm = sum(map(int, filter(lambda x: x.isdigit(), INPUT)))
outTreeList=list(map(lambda x: str(sm - int(x)) if x.isdigit() else x, INPUT))
print_custom_tree(list2node(outTreeList))

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
