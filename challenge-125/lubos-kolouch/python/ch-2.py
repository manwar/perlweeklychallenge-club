#!/usr/bin/env python
# -*- coding: utf-8 -*-


class Node:
    def __init__(self, value, left=None, right=None):
        self.value = value
        self.left = left
        self.right = right


class BinaryTree:
    def __init__(self, root):
        self.root = root

    def diameter(self):
        _, diameter = self._depth(self.root)
        return diameter

    def _depth(self, node):
        if not node:
            return 0, 0

        left_depth, left_diameter = self._depth(node.left)
        right_depth, right_diameter = self._depth(node.right)
        max_diameter = max(left_diameter, right_diameter, left_depth + right_depth)

        return max(left_depth, right_depth) + 1, max_diameter


# Test
tree = BinaryTree(
    Node(
        1,
        Node(2, Node(3), Node(4)),
        Node(5, Node(6), Node(7, Node(8, Node(9)), Node(10))),
    )
)

print(tree.diameter())  # prints: 6
