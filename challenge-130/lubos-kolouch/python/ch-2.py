#!/usr/bin/env python
# -*- coding: utf-8 -*-

class Node:
    def __init__(self, value, left=None, right=None):
        self.value = value
        self.left = left
        self.right = right


def is_bst(node, min_val=float('-inf'), max_val=float('inf')):
    if node is None:
        return True
    if not min_val <= node.value <= max_val:
        return False
    return is_bst(node.left, min_val, node.value - 1) and is_bst(node.right, node.value + 1, max_val)


tree = Node(8, Node(5, Node(4), Node(6)), Node(9))
print(1 if is_bst(tree) else 0)
