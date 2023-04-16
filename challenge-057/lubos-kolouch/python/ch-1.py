#!/usr/bin/env python
# -*- coding: utf-8 -*-

class BinaryTree:
    def __init__(self, value, left=None, right=None):
        self.value = value
        self.left = left
        self.right = right

    def invert(self):
        self.left, self.right = self.right, self.left
        if self.left:
            self.left.invert()
        if self.right:
            self.right.invert()

    def pretty_print(self, padding="", branch_padding=""):
        if self.right:
            self.right.pretty_print(padding + " ", padding + "|")

        print(branch_padding, end="")
        if branch_padding:
            print("--", end="")
        print(self.value)

        if self.left:
            self.left.pretty_print(padding + " ", padding + "|")


if __name__ == "__main__":
    tree = BinaryTree(
        1,
        BinaryTree(
            2,
            BinaryTree(4),
            BinaryTree(5)
        ),
        BinaryTree(
            3,
            BinaryTree(6),
            BinaryTree(7)
        )
    )

    print("Original tree:")
    tree.pretty_print()

    tree.invert()

    print("\nInverted tree:")
    tree.pretty_print()
