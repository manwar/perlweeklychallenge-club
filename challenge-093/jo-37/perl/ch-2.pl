#!/usr/bin/perl

use v5.16;
use Test2::V0;
use experimental qw(signatures postderef);

$::verbose = 1;

# Simplistic binary tree implementation:
# Each node $n is an array ref with
# - $n->[0] pointing to the left sub tree
# - $n->[1] pointing to the right sub tree
# - $n->[2] holding the node data

# Sum node values over the paths from the start node to every leaf node.
# The total should be modified at leaf nodes only, therefore it is
# passed as a reference.  $path holds the sum of the node values in the
# path from the root to the current node.  Descent into child trees
# with an updated path sum or otherwise, at a leaf node, add the path
# sum to the total.

sub sum_path;
sub sum_path ($total, $path, $tree) {

    # Augment path sum by current node value.
    $path += $tree->[2];

    # Descent into existing sub trees, counting these.
    my $subtrees;
    $subtrees += sum_path $total, $path, $_ for grep $_, $tree->@[0, 1];

    # We are at a leaf node when there were no sub trees.
    unless ($subtrees) {
        $$total += $path;
        say "leaf: node=$tree->[2], path=$path, total=$$total" if $::verbose;
    }

    # Always return one as a sub tree indicator.
    1;
}

# Convenience wrapper for sum_path to process a whole tree from its root.
sub sum_tree ($root) {
    sum_path \my $total, 0, $root;
    $total;
}

### main ###

pass 'init';

#      1
#     /
#    2
#   / \
#  3   4

is sum_tree(
    [
        [
            [undef, undef, 3],
            [undef, undef, 4],
        2],
        undef,
    1]),
    13, 'Example 1';

#      1
#     / \
#    2   3
#   /   / \
#  4   5   6

is sum_tree(
    [
        [
            [undef, undef, 4],
            undef,
        2],
        [
            [undef, undef, 5],
            [undef, undef, 6],
        3],
    1]),
    26, 'Example 2';

#       1
#      / \
#     /   \
#    2     3
#   / \   / \
#  4   5 6   7
is sum_tree(
    [
        [
            [undef, undef, 4],
            [undef, undef, 5],
        2],
        [
            [undef, undef, 6],
            [undef, undef, 7],
        3],
    1]),
    36, 'full tree';

#      1
#     /
#    2
#   /
#  3
is sum_tree(
    [
        [
            [undef, undef, 3],
            undef,
        2],
        undef,
    1]),
    6, 'left rod';

#  1
#   \
#    2
#     \
#      3
is sum_tree(
    [
        undef,
        [
            undef,
            [undef, undef, 3],
        2],
    1]),
    6, 'right rod';

done_testing;
