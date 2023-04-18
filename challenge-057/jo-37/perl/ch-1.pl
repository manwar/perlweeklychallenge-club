#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use Data::Dump;
use experimental 'signatures';

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [NODE...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

NODE...
    nodes of the binary tree in the form id[:[left][,right]]

EOS


### Input and Output

main: {
    my $tree = build_tree(@ARGV);
    dd $tree;
    dd invert_tree($tree);
}


### Implementation

# Representing a binary tree as a set of nodes, where each node is an
# array ref of three elements:
# - the node's id
# - references to the left and right child nodes
#
# Helper to build a binary tree from a string representation of its
# nodes.  Each node is given by "id[:[left][,right]]".  The nodes may be
# specified in any order except for the root, which must be given as the
# first node.
sub build_tree {
    my %nodes;
    my $root;
    for my $node (@_) {
        my ($id, @children) = $node =~ /^(\d+)(?::(\d+)?(?:,(\d+))?)?/;
        $root //= $id;
        $nodes{$id}[0] = $id;
        push $nodes{$id}->@*, map {defined ? $nodes{$_} = [] : undef}
            @children;
    }

    $nodes{$root};
}

# Recursively invert the tree.
sub invert_tree ($tree) {
    invert_tree($_) for grep defined, $tree->@[1, 2];
    $tree->@[1, 2] = $tree->@[2, 1];
    $tree;
}



### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is invert_tree(
            build_tree('1:2,3', '2:4,5', '3:6,7', '4', '5', '6', '7')),
        [1,
            [3, [7, undef, undef], [6, undef, undef]],
            [2, [5, undef, undef], [4, undef, undef]]], 'example';
    }

    SKIP: {
        skip "tests" unless $tests;
        is invert_tree(build_tree('1:2,3', '2:4', '3:,7', '4', '7')),
            [1, [3, [7, undef, undef], undef], [2, undef, [4, undef, undef]]],
            'handle missing childs';
	}

    done_testing;
    exit;
}
