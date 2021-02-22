#!/usr/bin/perl

# Challenge 093
#
# TASK #2 › Sum Path
# Submitted by: Mohammad S Anwar
# You are given binary tree containing numbers 0-9 only.
#
# Write a script to sum all possible paths from root to leaf.
#
# Example 1:
# Input:
#      1
#     /
#    2
#   / \
#  3   4
#
# Output: 13
# as sum two paths (1->2->3) and (1->2->4)
# Example 2:
# Input:
#      1
#     / \
#    2   3
#   /   / \
#  4   5   6
#
# Output: 26
# as sum three paths (1->2->4), (1->3->5) and (1->3->6)

use strict;
use warnings;
use 5.030;

# tree object
{
    package Tree;
    use Object::Tiny::RW qw( value left right );
}

my $tree = parse_tree();
say add_tree_paths($tree);


sub parse_tree {
    chomp(my @lines = <>);
    @lines or die "malformed tree\n";
    $lines[0] =~ /^( +)\d/ or die "malformed tree\n";
    $tree = parse_subtree(\@lines, 0, length($1));
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
        if ($col-2 >= 0 && substr($lines->[$row+1], $col-1, 1) eq '/') {
            my $child = parse_subtree($lines, $row+2, $col-2);
            $node->left($child);
        }
        # parse right subtree
        if ($col+2 < length($lines->[$row+2]) && substr($lines->[$row+1], $col+1, 1) eq '\\') {
            my $child = parse_subtree($lines, $row+2, $col+2);
            $node->right($child);
        }
    }
    return $node;
}

sub add_tree_paths {
    my($tree) = @_;
    my $sum = 0;
    add_subtree_paths($tree, \$sum);
    return $sum;
}

sub add_subtree_paths {
    my($tree, $psum, $partial_sum) = @_;
    $partial_sum += $tree->value;
    if ($tree->left) {
        add_subtree_paths($tree->left, $psum, $partial_sum);
    }
    if ($tree->right) {
        add_subtree_paths($tree->right, $psum, $partial_sum);
    }
    if (!$tree->left && !$tree->right) {    # at a leaf?
        $$psum += $partial_sum;
    }
}
