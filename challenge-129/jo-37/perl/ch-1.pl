#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Graph;
use experimental qw(signatures);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [id:left:right ... node ...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

id:left:right ...
    nodes of the binary tree as node id, left child, right child.  At
    least one colon must be present to distinguish node definitions from
    target nodes.  The first id is taken as the root node.

node ...
    list of nodes for which the distance from the root shall be found.

The first example may be specified as:
$0 1:2:3 3::4 4:5:6 6 5 2 4

EOS


### Input and Output

main: {
    my ($apsp, $root) = apsp(grep /:/, @ARGV);
    say "d($root, $_) = ", node_distance($apsp, $root, $_)
        for grep !/:/, @ARGV;
}


### Implementation

# Build the binary tree as a graph.  As the distance from the root node
# to any target node is taken top-down, the graph may be constructed as
# a directed graph.  Taking the first given node as the root - all
# remaining nodes may be given in any order.  Then find the shortest
# paths between all pairs of nodes using Floyd-Warshall's algorithm.
# The resulting all-pairs shortest path object can then be queried for
# the distance between the root and any other node of the tree.  This is
# just a small modification of the solution to week 125 task 2.
sub apsp (@nodes) {
    my $g = Graph->new(directed => 1);
    my $root;
    for my $node (@nodes) {
        my ($id, $left, $right) = split /:/, $node;
        $root //= $id;
        $g->add_edge($id, $left) if $left;
        $g->add_edge($id, $right) if $right;
    }
    ($g->all_pairs_shortest_paths, $root);
}

sub node_distance ($apsp, $root, $node) {
    $apsp->path_length($root, $node);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        {
            my ($apsp, $root) = apsp(qw(1:2:3 3::4 4:5:6));
            is node_distance($apsp, $root, 6), 3, 'example 1a';
            is node_distance($apsp, $root, 5), 3, 'example 1b';
            is node_distance($apsp, $root, 2), 1, 'example 1c';
            is node_distance($apsp, $root, 4), 2, 'example 1d';
        }
        {
            my ($apsp, $root) =
                apsp(qw(1:2:3 2:4 4::6 6:8:9 3::5 5:7));
            is node_distance($apsp, $root, 7), 3, 'example 2a';
            is node_distance($apsp, $root, 8), 4, 'example 2b';
            is node_distance($apsp, $root, 6), 3, 'example 2c';
        }
    }


    SKIP: {
        skip "tests" unless $tests;

        my ($apsp, $root) = apsp('1:2:3');
        is node_distance($apsp, 1, 1), 0,
            'zero length path from the root to itself';
        is node_distance($apsp, 2, 1), U(),
            'no path from a node to the root';
        is node_distance($apsp, 2, 3), U(),
            'no path between non-root nodes';
	}

    done_testing;
    exit;
}
