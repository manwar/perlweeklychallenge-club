#!/usr/bin/env python3

###########################################################################
# script name: ch-2.py                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-056/         #
#                                                                         #
# Path Sum                                                                #
# You are given a binary tree and a sum, write a script to find if        #
# the tree has a path such that adding up all the values along the path   #
# equals the given sum. Only complete paths (from root to leaf node) may  #
# be considered for a sum.                                                #
#                                                                         #
# Example                                                                 #
# Given the below binary tree and sum = 22,                               #
#                                                                         #
#             5                                                           #
#            / \                                                          #
#           4   8                                                         #
#          /   / \                                                        #
#         11  13  9                                                       #
#        /  \      \                                                      #
#       7    2      1                                                     #
#                                                                         #
# For the given binary tree, the partial path sum 5 -> 8 -> 9 = 22 is     #
# not valid.                                                              #
# The script should return the path 5 -> 4 -> 11 -> 7 whose sum is 22     #
#                                                                         #
###########################################################################

class Node:
    def __init__(self,key):
        self.left  = None
        self.right = None
        self.val   = key

branchMemory = []
k = 22
match = 0

def preOrder(root, toLeafSum):
    if root:
        toLeafSum += root.val
        if root.left != None and root.right != None:
            branchMemory.append(toLeafSum)
        if root.left == None and root.right == None:
            if toLeafSum == k:
                global match
                match += 1
            if len(branchMemory) > 0:
                toLeafSum = branchMemory.pop()
        preOrder(root.left,  toLeafSum)
        preOrder(root.right, toLeafSum)

bTree = Node(5)
bTree.left = Node(4)
bTree.left.left = Node(11)
bTree.left.left.left  = Node(7)
bTree.left.left.right = Node(2)
bTree.right = Node(8)
bTree.right.left  = Node(13)
bTree.right.right = Node(9)
bTree.right.right.right = Node(1)

tLS = 0
preOrder(bTree,tLS)

if  match == 0:
    print('No branch equals', k)
elif match == 1:
    print('1 branch equals', k)
else:
    print(match, 'branches equal', k)

# output:
#
# 1 branch equals 22
