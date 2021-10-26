#!/usr/bin/env perl

# TASK #1 > Root Distance
# Submitted by: Mohammad S Anwar
# You are given a tree and a node of the given tree.
#
# Write a script to find out the distance of the given node from the root.
#
# Example 1:
# Tree:
#         1
#        / \
#       2   3
#            \
#             4
#            / \
#           5   6
#
# Node: 6
# Output: 3 as the distance of given node 6 from the root (1).
#
# Node: 5
# Output: 3
#
# Node: 2
# Output: 1
#
# Node: 4
# Output: 2
# Example 2:
# Tree:
#         1
#        / \
#       2   3
#      /     \
#     4       5
#      \     /
#       6   7
#      / \
#     8   9
#
# Node: 7
# Output: 3 as the distance of given node 6 from the root (1).
#
# Node: 8
# Output: 4
#
# Node: 6
# Output: 3

use Modern::Perl;

# tree object
{
    package Tree;
    use Object::Tiny::RW qw( value left right );
}

sub parse_tree {
    chomp(my @lines = <STDIN>);
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

sub root_dist {
    my($node, $value, $dist) = @_;
    $dist ||= 0;
    return $dist if $value == $node->value;
    if ($node->left) {
        my $found = root_dist($node->left, $value, $dist+1);
        return $found if $found > 0;
    }
    if ($node->right) {
        my $found = root_dist($node->right, $value, $dist+1);
        return $found if $found > 0;
    }
    return -1;
}

my $tree = parse_tree();
my $value = shift||0;
say(root_dist($tree, $value));
