#!/usr/bin/env python3

# TASK #2 > Binary Search Tree
# Submitted by: Mohammad S Anwar
# You are given a tree.
# 
# Write a script to find out if the given tree is Binary Search Tree
# (BST).
# 
# According to wikipedia, the definition of BST:
# 
# A binary search tree is a rooted binary tree, whose internal nodes
# each store a key (and optionally, an associated value), and each has
# two distinguished sub-trees, commonly denoted left and right. The
# tree additionally satisfies the binary search property: the key in
# each node is greater than or equal to any key stored in the left
# sub-tree, and less than or equal to any key stored in the right
# sub-tree. The leaves (final nodes) of the tree contain no key and
# have no structure to distinguish them from one another.
# 
# Example 1
# Input:
#         8
#        / \
#       5   9
#      / \
#     4   6
# 
# Output: 1 as the given tree is a BST.
# Example 2
# Input:
#         5
#        / \
#       4   7
#      / \
#     3   6
# 
# Output: 0 as the given tree is a not BST.

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

def subtree_min(node):
    min_value = node.value
    if node.left:
        min_value = min(min_value, subtree_min(node.left))
    if node.right:
        min_value = min(min_value, subtree_min(node.right))
    return min_value

def subtree_max(node):
    max_value = node.value
    if node.left:
        max_value = max(max_value, subtree_max(node.left))
    if node.right:
        max_value = max(max_value, subtree_max(node.right))
    return max_value

def subtree_is_bst(node):
    if node.left:
        if not subtree_is_bst(node.left):
            return 0
        if subtree_max(node.left) > node.value:
            return 0
    if node.right:
        if not subtree_is_bst(node.right):
            return 0
        if subtree_min(node.right) < node.value:
            return 0
    return 1

tree = parse(read_input())
print(subtree_is_bst(tree))
