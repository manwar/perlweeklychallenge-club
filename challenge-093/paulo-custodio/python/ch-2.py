#!/usr/bin/env python

# Challenge 093
#
# TASK #2 > Sum Path
# Submitted by: Mohammad S Anwar
# You are given binary tree containing numbers 0-9 only.
#
# Write a script to sum all possible paths from root to leaf.
#
# Example 1:
# Input:
#      1
#     /
#    2
#   / \
#  3   4
#
# Output: 13
# as sum two paths (1->2->3) and (1->2->4)
# Example 2:
# Input:
#      1
#     / \
#    2   3
#   /   / \
#  4   5   6
#
# Output: 26
# as sum three paths (1->2->4), (1->3->5) and (1->3->6)

import fileinput
import re

class Node:
    """one node of a tree"""
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

    def __repr__(self):
        return "Node(value: {}, left: {}, right: {})" \
                .format(self.value, self.left, self.right)

def read_input():
    """read standard input into array"""
    lines = []
    for line in fileinput.input():
        lines.append(line)
    return lines

def parse(lines):
    """parse a tree, return root Node"""

    def parse_subtree(lines, row, col):
        """parse a sub-tree, return root Node"""
        def ch(row, col):
            if row < 0 or row >= len(lines) or col < 0 or col >= len(lines[row]):
                return ' '
            else:
                return lines[row][col]

        tree = Node(int(lines[row][col]))
        if ch(row + 1, col - 1) == '/':
            tree.left = parse_subtree(lines, row + 2, col - 2)
        if ch(row + 1, col + 1) == '\\':
            tree.right = parse_subtree(lines, row + 2, col + 2)

        return tree

    found = re.search("^[ ]+\d", lines[0])
    col = found.span()[1] - 1
    return parse_subtree(lines, 0, col)

def add_tree_paths(tree):
    """sum all sub-tree paths"""

    def add_subtree_paths(node, cur_len, total_len):
        """return the subtree path len"""
        cur_len += node.value
        if node.left:
            total_len = add_subtree_paths(node.left, cur_len, total_len)
        if node.right:
            total_len = add_subtree_paths(node.right, cur_len, total_len)
        if not node.left and not node.right:        # at a leaf
            total_len += cur_len
        return total_len

    return add_subtree_paths(tree, 0, 0)

def solve():
    lines = read_input()
    tree = parse(lines)
    print(add_tree_paths(tree))

solve()
