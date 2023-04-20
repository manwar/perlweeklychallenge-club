#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use experimental 'signatures';

our ($tests, $examples, $sum);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless defined $sum && @ARGV;
usage: $0 [-examples] [-tests] [-sum=SUM NODE...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-sum=SUM
    path sum from root to leaf

NODE
    nodes of the binary tree in the form "id:value,left,right".  The
    root node must have an id of "ROOT".
    The task's example may be specified as:
    ROOT:5,n11,n12 n11:4,n21 n12:8,n22,n23 n21:11,n31,n32 n22:13
        n23:9,,n33 n31:7 n32:2 n33:1

EOS


### Input and Output

say "(@$_)" for find_path_sum(build_tree(@ARGV), [], $sum, [])->@*;


### Implementation

# Helper to build a binary tree.  Each node is represented by a string
# of the form "id:value,left,right" where:
# - id is a unique identifier for each node
# - value is the node's value
# - left and right are the identifier of the left and right child nodes,
#   if these exist.
# The nodes may be specified in any order and the root node must have an
# id of "ROOT".
#
# The binary tree itself is represented by an array ref of nodes, where
# each node consists of:
# $node->[0]: its value
# $node->[1], $node->[2]: references to the left and right child nodes,
# if these exist.

sub build_tree {
    my %nodes;
    for my $node (@_) {
        my ($id, $val, $left, $right) = split /[:,]/, $node;
        ($nodes{$id} //= [])->[0] = $val;
        $nodes{$id}[1] = $nodes{$left} //= [] if $left;
        $nodes{$id}[2] = $nodes{$right} //= [] if $right;
    }

    $nodes{ROOT};
}

sub find_path_sum ($tree, $prefix, $sum, $path) {
    $sum -= $tree->[0];
    if ($sum == 0 && !$tree->[1] && !$tree->[2]) {
        push @$path, [@$prefix, $tree->[0]];
        return $path;
    }
    for my $sub ($tree->@[1, 2]) {
        find_path_sum($sub, [@$prefix, $tree->[0]], $sum, $path) if $sub;
    }

    $path;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is find_path_sum([5, [4, [11, [7], [2]]], [8, [13], [9, undef, [1]]]],
            [], 22, []),
            [[5, 4, 11, 2]], 'example';
    }

    SKIP: {
        skip "tests" unless $tests;

        is build_tree('ROOT:5,n11,n12',
            'n11:4,n21', 'n12:8,n22,n23',
            'n21:11,n31,n32', 'n22:13', 'n23:9,,n33',
            'n31:7', 'n32:2', 'n33:1'),
            [5, [4, [11, [7], [2]]], [8, [13], [9, undef, [1]]]],
            'build example tree';
	}

    done_testing;
    exit;
}
