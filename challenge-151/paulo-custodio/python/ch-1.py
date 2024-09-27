#!/usr/bin/env python3

# Challenge 151
#
# TASK #1 > Binary Tree Depth
# Submitted by: Mohammad S Anwar
# You are given binary tree.
#
# Write a script to find the minimum depth.
#
# The minimum depth is the number of nodes from the root to the nearest leaf
# node (node without any children).
#
# Example 1:
# Input: '1 | 2 3 | 4 5'
#
#                 1
#                / \
#               2   3
#              / \
#             4   5
#
# Output: 2
#
# Example 2:
# Input: '1 | 2 3 | 4 *  * 5 | * 6'
#
#                 1
#                / \
#               2   3
#              /     \
#             4       5
#              \
#               6
# Output: 3

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

def min_depth(tree):
    if not tree:
        return 0
    else:
        return 1+min(min_depth(tree.left), min_depth(tree.right))

tree = parse_tree(read_input())
print(min_depth(tree))
