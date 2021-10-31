#!/usr/bin/env perl

# TASK #2 > Binary Search Tree
# Submitted by: Mohammad S Anwar
# You are given a tree.
#
# Write a script to find out if the given tree is Binary Search Tree
# (BST).
#
# According to wikipedia, the definition of BST:
#
# A binary search tree is a rooted binary tree, whose internal nodes
# each store a key (and optionally, an associated value), and each has
# two distinguished sub-trees, commonly denoted left and right. The
# tree additionally satisfies the binary search property: the key in
# each node is greater than or equal to any key stored in the left
# sub-tree, and less than or equal to any key stored in the right
# sub-tree. The leaves (final nodes) of the tree contain no key and
# have no structure to distinguish them from one another.
#
# Example 1
# Input:
#         8
#        / \
#       5   9
#      / \
#     4   6
#
# Output: 1 as the given tree is a BST.
# Example 2
# Input:
#         5
#        / \
#       4   7
#      / \
#     3   6
#
# Output: 0 as the given tree is a not BST.

use Modern::Perl;
use List::Util qw( min max );

# tree object
{
    package Tree;
    use Object::Tiny::RW qw( value left right );
}

sub parse_tree {
    chomp(my @lines = <>);
    @lines or die "malformed tree\n";
    $lines[0] =~ /^( +)\d/ or die "malformed tree\n";
    my $tree = parse_subtree(\@lines, 0, length($1));
    return $tree;
}

sub parse_subtree {
    my($lines, $row, $col) = @_;

    # parse root
    my $value = substr($lines->[$row], $col, 1);
    $value =~ /\d/ or die "malformed tree\n";
    my $node = Tree->new(value => $value);

    # parse children
    if ($row+2 <= $#{$lines}) {
        # parse left subtree
        if ($col-2 >= 0 &&
            $col-2 < length($lines->[$row+1]) &&
            substr($lines->[$row+1], $col-1, 1) eq '/') {
            my $child = parse_subtree($lines, $row+2, $col-2);
            $node->left($child);
        }
        # parse right subtree
        if ($col+2 < length($lines->[$row+2]) &&
            substr($lines->[$row+1], $col+1, 1) eq '\\') {
            my $child = parse_subtree($lines, $row+2, $col+2);
            $node->right($child);
        }
    }
    return $node;
}

sub subtree_min {
    my($node) = @_;
    my $min = $node->value;
    if ($node->left) {
        $min = min($min, subtree_min($node->left));
    }
    if ($node->right) {
        $min = min($min, subtree_min($node->right));
    }
    return $min;
}

sub subtree_max {
    my($node) = @_;
    my $max = $node->value;
    if ($node->left) {
        $max = max($max, subtree_max($node->left));
    }
    if ($node->right) {
        $max = max($max, subtree_max($node->right));
    }
    return $max;
}

sub subtree_is_bst {
    my($node) = @_;
    if ($node->left) {
        return 0 if !subtree_is_bst($node->left);
        return 0 if subtree_max($node->left) > $node->value;
    }
    if ($node->right) {
        return 0 if !subtree_is_bst($node->right);
        return 0 if subtree_min($node->right) < $node->value;
    }
    return 1;
}

my $tree = parse_tree();
say subtree_is_bst($tree);
