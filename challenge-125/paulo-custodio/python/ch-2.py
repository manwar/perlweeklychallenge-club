#!/usr/bin/env python3

# TASK #2 > Binary Tree Diameter
# Submitted by: Mohammad S Anwar
# You are given binary tree as below:
#
#     1
#    / \
#   2   5
#  / \ / \
# 3  4 6  7
#        / \
#       8  10
#      /
#     9
# Write a script to find the diameter of the given binary tree.
#
# The diameter of a binary tree is the length of the longest path between any
# two nodes in a tree. It doesn't have to pass through the root.
#
# For the above given binary tree, possible diameters (6) are:
#
# 3, 2, 1, 5, 7, 8, 9
#
# or
#
# 4, 2, 1, 5, 7, 8, 9
#
# UPDATE (2021-08-10 17:00:00 BST): Jorg Sommrey corrected the example.
# The length of a path is the number of its edges, not the number of the
# vertices it connects. So the diameter should be 6, not 7.

import fileinput
import re

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

def parse(lines):
    found = re.search("^[ ]+\d", lines[0])
    col = found.span()[1] - 1
    return parse_subtree(lines, 0, col)

def height(node):
    if node is None:
        return 0
    return 1 + max(height(node.left), height(node.right))

def diameter(root):
    if root is None:
        return 0

    lheight = height(root.left)
    rheight = height(root.right)

    ldiameter = diameter(root.left)
    rdiameter = diameter(root.right)

    return max(lheight + rheight + 1, max(ldiameter, rdiameter))-1

tree = parse(read_input())
print(diameter(tree))
