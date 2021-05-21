#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Data::Dump;
use experimental qw(signatures postderef);

our $examples;

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [node ...]

-examples
    run the examples from the challenge
 
node ...
    build binary tree from given nodes.  Each node has the form:
    id:value[:left[:right]]
    where
        id is a unique node identifier
        value is the node's value
        left is the id of the left child node (may be missing or empty)
        right is the id of the right child node (may be missing)
    The nodes may be specified in any order, but the root node must have
    an id of 'ROOT'.  The given example could be written as

    ROOT:1:n2:n3 n2:2:n4 n4:4::n7 n3:3:n5:n6 n5:5 n6:6 n7:7

EOS

### Input and Output

# A price winning solution to this task will certainly provide a nice
# print-out of the binary tree.  So this is out of the running.

my $tree = BinaryTree->build(@ARGV);
dd [@$tree];
recreate_tree($tree);
dd [@$tree];


### Implementation

sub recreate_tree ($tree) {

    # Get the sum of all node values and collect references to them.
    my $sum;
    my @nodes;
    $tree->traverse(sub {
            $sum += $_->[0];
            push @nodes, \$_->[0];
        });

    # Adjust the nodes' values as the sum minus the old value.
    $$_ = $sum - $$_ for @nodes;
}

package BinaryTree;

# Re-using the binary tree implementation from challenge 094 with
# slight modifications: NRL only traversal and an additional
# constructor.

# Minimal object implementation of a binary tree providing just the
# methods required for this task.
#
# Each node $n is represented by an array reference with:
# $n->[0] holding the node data
# $n->[1] pointing to the left sub tree
# $n->[2] pointing to the right sub tree
#
# The tree root is the only blessed node in the tree.

# Constructor for a binary tree with up to three arguments:
# - the root node's data
# - an optional left sub tree
# - an optional right sub tree
sub new ($class, $data, $left=undef, $right=undef) {
    bless [$data, $left, $right], $class;
}

# Transformed the sub "build_tree" from challenge 094 into an
# alternative constructor.  Each node has the form:
# id:value[:left[:right]]
# See help text.
sub build ($class, @nodes) {
    # Capture nodes.
    my %nodes = map {
        my ($id, %val);
        ($id, @val{qw(val left right)}) = split /:/;
        ($id => \%val)
    } @nodes;

    # Dynamically build the tree from the given nodes while traversing.
    my $tree = $class->new('ROOT');
    $tree->traverse(sub {
        my %node = $nodes{$_->[0]}->%*;
        $_->[0] = $node{val};
        $_->[1] = [$node{left}] if $node{left};
        $_->[2] = [$node{right}] if $node{right};
    });

    $tree;
}

# Depth-first NLR traversal of the binary tree starting from its root.
# The code ref is called for every node with $_ set to the current node.
sub traverse ($self, $code) {
    # Recursively process the tree in NLR order.  Nodes are
    # not blessed and thus have no methods.
    do {local $_ = $self; $code->()};
    traverse($_, $code) for grep $_, $self->@[1 .. $#$self];
}


### Examples and tests

package main;

sub run_tests {

    my $tree = BinaryTree->new(
        1, [2, [4, undef, [7]]], [3, [5], [6]]
    );
    recreate_tree($tree);
    is $tree, [27, [26, [24, undef, [21]]], [25, [23], [22]]],
        'example';

    done_testing;
    exit;
}
