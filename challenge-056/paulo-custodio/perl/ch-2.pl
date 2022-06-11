#!/usr/bin/env perl

# Challenge 056
#
# TASK #2
# Path Sum
# You are given a binary tree and a sum, write a script to find if the tree has
# a path such that adding up all the values along the path equals the given sum.
# Only complete paths (from root to leaf node) may be considered for a sum.
#
# Example
# Given the below binary tree and sum = 22,
#
#           5
#          / \
#         4   8
#        /   / \
#       11  13  9
#      /  \      \
#     7    2      1
# For the given binary tree, the partial path sum 5 ? 8 ? 9 = 22 is not valid.
#
# The script should return the path 5 ? 4 ? 11 ? 2 whose sum is 22.

use Modern::Perl;
use List::Util qw( sum );

# tree object
{
    package Tree;
    use Object::Tiny::RW qw( value left right );
}

my $sum = shift;
my $tree = parse_tree();
path_sum([], $sum, $tree);

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

sub path_sum {
    my($path, $sum, $tree) = @_;
    my @path = @$path;
    push @path, $tree->value;

    if (!$tree->left && !$tree->right) {
        say "@path" if sum(@path)==$sum;
    }
    else {
        path_sum([@path], $sum, $tree->left) if $tree->left;
        path_sum([@path], $sum, $tree->right) if $tree->right;
    }
}
