#!/usr/bin/env python3

# Challenge 113
#
# TASK #2 - Recreate Binary Tree
# Submitted by: Mohammad S Anwar
# You are given a Binary Tree.
#
# Write a script to replace each node of the tree with the sum of all the
# remaining nodes.
#
# Example
# Input Binary Tree
#         1
#        / \
#       2   3
#      /   / \
#     4   5   6
#      \
#       7
# Output Binary Tree
#         27
#        /  \
#       26  25
#      /   /  \
#     24  23  22
#      \
#      21

import sys
import re
import fileinput

def read_input():
    lines = []
    for line in fileinput.input():
        lines.append(line)
    return lines

tree = "".join(read_input())
nums = [int(x) for x in re.findall(r"\d+", tree)]
sum = sum(nums)
for num in nums:
    tree = re.sub(r"\b"+str(num)+r"\b ?", str(sum-num), tree)
tree = re.sub(r"\n$", "", tree)
print(tree)
