#!/usr/bin/env python3

# Challenge 129
#
# TASK #1 > Root Distance
# Submitted by: Mohammad S Anwar
# You are given a tree and a node of the given tree.
#
# Write a script to find out the distance of the given node from the root.
#
# Example 1:
# Tree:
#         1
#        / \
#       2   3
#            \
#             4
#            / \
#           5   6
#
# Node: 6
# Output: 3 as the distance of given node 6 from the root (1).
#
# Node: 5
# Output: 3
#
# Node: 2
# Output: 1
#
# Node: 4
# Output: 2
# Example 2:
# Tree:
#         1
#        / \
#       2   3
#      /     \
#     4       5
#      \     /
#       6   7
#      / \
#     8   9
#
# Node: 7
# Output: 3 as the distance of given node 6 from the root (1).
#
# Node: 8
# Output: 4
#
# Node: 6
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

def parse(lines):
    found = re.search("^[ ]+\d", lines[0])
    col = found.span()[1] - 1
    return parse_subtree(lines, 0, col)

def root_dist(tree, value):
    def subtree_dist(node, value, dist):
        if value == node.value:
            return dist
        if node.left:
            found = subtree_dist(node.left, value, dist+1)
            if found > 0:
                return found
        if node.right:
            found = subtree_dist(node.right, value, dist+1)
            if found > 0:
                return found
        return -1

    return subtree_dist(tree, value, 0)

value = int(sys.argv.pop())
tree = parse(read_input())
dist = root_dist(tree, value)
print(dist)
