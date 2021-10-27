#!/usr/bin/env perl

# TASK #2 > Binary Tree Diameter
# Submitted by: Mohammad S Anwar
# You are given binary tree as below:
#
#     1
#    / \
#   2   5
#  / \ / \
# 3  4 6  7
#        / \
#       8  10
#      /
#     9
# Write a script to find the diameter of the given binary tree.
#
# The diameter of a binary tree is the length of the longest path between any
# two nodes in a tree. It doesn't have to pass through the root.
#
# For the above given binary tree, possible diameters (6) are:
#
# 3, 2, 1, 5, 7, 8, 9
#
# or
#
# 4, 2, 1, 5, 7, 8, 9
#
# UPDATE (2021-08-10 17:00:00 BST): Jorg Sommrey corrected the example.
# The length of a path is the number of its edges, not the number of the
# vertices it connects. So the diameter should be 6, not 7.

use Modern::Perl;
use List::Util qw( max );

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

sub height {
    my($node) = @_;

    if (!$node) {
        return 0;
    }
    else {
        return 1 + max(height($node->left), height($node->right));
    }
}

sub diameter {
    my($node) = @_;

    if (!$node) {
        return 0;
    }

    my $lheight = height($node->left);
    my $rheight = height($node->right);

    my $ldiameter = diameter($node->left);
    my $rdiameter = diameter($node->right);

    return max($lheight + $rheight + 1, max($ldiameter, $rdiameter))-1;
}

my $tree = parse_tree();
say diameter($tree);
