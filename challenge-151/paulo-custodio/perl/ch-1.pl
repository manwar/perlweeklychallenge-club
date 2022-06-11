#!/usr/bin/env perl

# Challenge 151
#
# TASK #1 › Binary Tree Depth
# Submitted by: Mohammad S Anwar
# You are given binary tree.
#
# Write a script to find the minimum depth.
#
# The minimum depth is the number of nodes from the root to the nearest leaf
# node (node without any children).
#
# Example 1:
# Input: '1 | 2 3 | 4 5'
#
#                 1
#                / \
#               2   3
#              / \
#             4   5
#
# Output: 2
#
# Example 2:
# Input: '1 | 2 3 | 4 *  * 5 | * 6'
#
#                 1
#                / \
#               2   3
#              /     \
#             4       5
#              \
#               6
# Output: 3

use Modern::Perl;
use List::Util qw( min );

# tree object
{
    package Tree;
    use Object::Tiny::RW qw( value left right );
}

my $tree = parse_tree();
say min_depth($tree);


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

sub min_depth {
    my($tree) = @_;
    return 0 if !$tree;
    return 1+min( min_depth($tree->left), min_depth($tree->right) );
}
