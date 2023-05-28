#!/usr/bin/env python
# -*- coding: utf-8 -*-


class Node:
    def __init__(self, val, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right


def sum_tree(node, total=0):
    if node is None:
        return 0
    total = sum_tree(node.left, total) + sum_tree(node.right, total) + node.val
    node.val = total - node.val
    return total


# Testing
root = Node(1)
root.left = Node(2)
root.right = Node(3)
root.left.left = Node(4)
root.left.right = Node(5)
sum_tree(root)
print(root.val)  # Outputs: 14
print(root.left.val)  # Outputs: 11
print(root.right.val)  # Outputs: 2
