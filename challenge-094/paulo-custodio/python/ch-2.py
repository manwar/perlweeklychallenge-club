#!/usr/bin/env python

# Challenge 094
#
# TASK #2 > Binary Tree to Linked List
# Submitted by: Mohammad S Anwar
# You are given a binary tree.
#
# Write a script to represent the given binary tree as an object and flatten
# it to a linked list object. Finally print the linked list object.
#
# Example:
#   Input:
#
#       1
#      / \
#     2   3
#    / \
#   4   5
#      / \
#     6   7
#
#   Output:
#
#       1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3
#

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


def parse(lines):
    found = re.search("^[ ]+\d", lines[0])
    col = found.span()[1] - 1
    return parse_subtree(lines, 0, col)

def flatten(tree):
    if tree:
        left = tree.left
        right = tree.right
        flatten(left)
        flatten(right)
        tree.left = None
        tree.right = left
        node = tree
        while node.right:
            node = node.right
        node.right = right

def print_list(node):
    output = ""
    while node:
        output += str(node.value) + " -> "
        node = node.right
    output = output[:-4]
    print(output)

def solve():
    lines = read_input()
    tree = parse(lines)
    flatten(tree)
    print_list(tree)

solve()
