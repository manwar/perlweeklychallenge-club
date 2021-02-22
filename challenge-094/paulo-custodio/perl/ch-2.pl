#!/usr/bin/perl

# Challenge 094
#
# TASK #2 › Binary Tree to Linked List
# Submitted by: Mohammad S Anwar
# You are given a binary tree.
#
# Write a script to represent the given binary tree as an object and flatten
# it to a linked list object. Finally print the linked list object.
#
# Example:
#     Input:
#
#         1
#        / \
#       2   3
#      / \
#     4   5
#        / \
#       6   7
#
#     Output:
#
#         1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3

use strict;
use warnings;
use 5.030;

# tree object
{
    package Tree;
    use Object::Tiny::RW qw( value left right );
}

my $tree = flatten(parse_tree());

for (my $node = $tree; defined($node); $node = $node->right) {
    print $node->value;
    print " -> " if defined($node->right);
}
print "\n";


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
        if ($col-2 >= 0 && $col-2 < length($lines->[$row+1]) && substr($lines->[$row+1], $col-1, 1) eq '/') {
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

sub flatten {
    my($root) = @_;
    return if !defined($root);
    my $left = flatten($root->left);
    my $right = flatten($root->right);

    $root->left(undef);
    $root->right($left);

    my $node = $root;
    $node = $node->right while defined($node->right);

    $node->right($right);

    return $root;
}
