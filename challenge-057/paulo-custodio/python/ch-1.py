#!/usr/bin/env python3

# Challenge 057
#
# TASK #1 › Invert Tree
# You are given a full binary tree of any height, similar to the one below:
#
#
#
# Write a script to invert the tree, by mirroring the children of every node,
# from left to right. The expected output from the tree above would be:
#
#
#
# The input can be any sensible machine-readable binary tree format of your
# choosing, and the output should be the same format.
#
# BONUS
# In addition to the above, you may wish to pretty-print your binary tree in a
# human readable text-based format similar to the following:
#
#        1
#       /  \
#      3    2
#     / \  / \
#    7   6 5  4

import fileinput
import re
import sys

class Node:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

    def __repr__(self):
        return "Node(value: {}, left: {}, right: {})" \
                .format(self.value, self.left, self.right)

def read_input():
    lines = []
    for line in fileinput.input():
        lines.append(line)
    return lines

def parse_subtree(lines, row, col):
    def ch(row, col):
        if row < 0 or row >= len(lines) or \
           col < 0 or col >= len(lines[row]):
            return ' '
        else:
            return lines[row][col]

    tree = Node(int(lines[row][col]))
    if ch(row + 1, col - 1) == '/':
        tree.left = parse_subtree(lines, row + 2, col - 2)
    if ch(row + 1, col + 1) == '\\':
        tree.right = parse_subtree(lines, row + 2, col + 2)

    return tree

def parse_tree(lines):
    found = re.search(r'^[ ]+\d', lines[0])
    col = found.span()[1] - 1
    return parse_subtree(lines, 0, col)

def invert_tree(tree):
    if tree:
        tree.left, tree.right = tree.right, tree.left
        invert_tree(tree.left)
        invert_tree(tree.right)

def dump_tree(tree):
    if tree:
        print(tree.value, end='')
        if tree.left or tree.right:
            print("(", end='')
            dump_tree(tree.left)
            print("|", end='')
            dump_tree(tree.right)
            print(")", end='')

tree = parse_tree(read_input())
invert_tree(tree)
dump_tree(tree)
