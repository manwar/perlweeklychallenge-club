#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental qw(signatures postderef);
use Data::Dump qw(dd pp);

our ($verbose, $examples, $tests);

run_tests() if $examples || $tests;

say(<<EOS), exit unless @ARGV;
Usage: $0 [-examples] [-tests] [-verbose] [node ...]

-examples
    run examples from challenge

-tests
    run tests

-verbose
    enable trace output

node ...
    build binary tree from given nodes.  Each node has the form:
    id:value[:left[:right]]
    where
        id is a unique node identifier
        value is the node's value
        left is the id of the left child node (may be missing or empty)
        right is the id of the right child node (may be missing)
    The nodes may be specified in any order, but the root node must have
    an id of 'ROOT'.  The given example 1 could be written as
	ROOT:1:n2 n2:2:n3:n4 n3:3 n4:4
EOS

my $nodes = capture_nodes(@ARGV);
dd $nodes if $verbose;

my $tree = [undef, undef, 'ROOT'];
build_tree($tree, $nodes);
dd $tree if $verbose;

say sum_tree($tree);

# Backported from challenge 094
sub capture_nodes {
    # capture nodes
    my %nodes = map {
        my ($key, %val); ($key, @val{qw(val left right)}) = split /:/;
        ($key => \%val)
    } @_;
	\%nodes;
}

# Simplistic binary tree implementation:
# Each node $n is an array ref with
# - $n->[0] pointing to the left sub tree
# - $n->[1] pointing to the right sub tree
# - $n->[2] holding the node data

# Backported from challenge 094
sub build_tree ($node, $nodes) {
	my %node = $nodes->{$node->[2]}->%*;
	$node->[0] = [undef, undef, $node{left}] if $node{left};
	$node->[1] = [undef, undef, $node{right}] if $node{right};
	$node->[2] = $node{val};
	build_tree($node->[0], $nodes) if $node->[0];
	build_tree($node->[1], $nodes) if $node->[1];
}

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

sub run_tests {
	pass 'init';

	SKIP: {
		skip 'examples' unless $examples;
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
	}
	SKIP: {
		skip 'tests' unless $tests;
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
	}

	done_testing;
	exit;
}
