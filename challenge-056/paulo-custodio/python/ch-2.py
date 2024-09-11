#!/usr/bin/env python3

# Challenge 056
#
# TASK #2
# Path Sum
# You are given a binary tree and a sum, write a script to find if the tree has
# a path such that adding up all the values along the path equals the given sum.
# Only complete paths (from root to leaf node) may be considered for a sum.
#
# Example
# Given the below binary tree and sum = 22,
#
#           5
#          / \
#         4   8
#        /   / \
#       11  13  9
#      /  \      \
#     7    2      1
# For the given binary tree, the partial path sum 5 ? 8 ? 9 = 22 is not valid.
#
# The script should return the path 5 ? 4 ? 11 ? 2 whose sum is 22.

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


def path_sum(path, sum1, tree):
    path1 = path+[tree.value]
    if not tree.left and not tree.right:
        if sum(path1) == sum1:
            print(" ".join([str(x) for x in path1]))
    else:
        if tree.left:
            path_sum(path1, sum1, tree.left)
        if tree.right:
            path_sum(path1, sum1, tree.right)

sum1 = int(sys.argv[1])
sys.argv.pop()
tree = parse_tree(read_input())
path_sum([], sum1, tree)
