#!/usr/bin/env perl

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

use Modern::Perl;
my $tree = join('', <>);
my $sum = 0;
$sum += $1 while $tree =~ /(\d+)/g;
$tree =~ s/(\d+) ?/$sum - $1/ge;
print $tree;
