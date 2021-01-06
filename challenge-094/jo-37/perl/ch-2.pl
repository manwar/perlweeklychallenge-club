#!/usr/bin/perl

use v5.16;
use warnings FATAL => 'all';
no warnings 'recursion';
use experimental qw(postderef signatures);
use Data::Dump;

# $::verbose = 1;

package LinkedList;
# Minimal object implementation of a singly linked list providing just
# the methods required for this task.  Inspired by Steven Lembark's
# LinkedList::Single.
#
# Each node $n is represented by an (unblessed) array reference with:
# $n->[0] pointing to the next node
# $n->[1] holding the node data
#
# The list head $h is a blessed array reference with:
# $h->[0] pointing to the current node
# $h->[1] pointing to the head node

# Constructor for an empty list.
sub new ($class) {
	bless [], $class;
}

# A list in boolean context shall be true when positioned on an existing
# node.  Returns false after iterating beyond the last node or if there
# are no nodes at all.
use overload
	bool => sub ($self, $, $) {!!$self->[0]};

# Getter for the current node's data.
sub data ($self) {
	$self->[0][1];
}

# Advance to the next node.
sub next ($self) {
	$self->[0] = $self->[0][0];
	
	# Enable method chaining.
	$self;
}

# Reset the current node to the head node.
sub head ($self) {
	$self->[0] = $self->[1];

	# Enable method chaining.
	$self;
}

# Insert a new node after the current node.  This operation cannot be
# used to insert a (new) head node - use "unshift" instead.
sub add ($self, $data) {
	$self->[0][0] = [$self->[0][0], $data];

	# Enable method chaining.
	$self;
}

# Retrieve node data as an array, starting from the head node.
sub as_array ($self) {
	my @arr;
	for ($self->head; $self; $self->next) {
		push @arr, $self->data;
	}
	@arr;
}

# Insert a new head node.
sub unshift ($self, $data) {
	$self->[1] = [$self->[1], $data];

	# Enable method chaining.
	$self;
}


package BinaryTree;
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

# Depth-first traversal of the binary tree starting from its root.  The
# three-character mode specifies the processing order of the nodes,
# where 'N' stands for the current node, 'L' for the left sub tree and
# 'R' for the right sub tree.  See
# https://en.wikipedia.org/wiki/Tree_traversal#Depth-first_search_of_binary_tree
# The code ref is called for every node according to the specified
# processing order with $_ set to the current node's data.
sub traverse ($self, $mode, $code) {
	# Recursively process the tree in the specified order.  Nodes are
	# not blessed and thus have no methods.
	foreach (split //, $mode) {
		do {local $_ = $self->[0]; $code->()} if /^N$/;
		traverse($self->[1], $mode, $code) if /^L$/ && $self->[1];
		traverse($self->[2], $mode, $code) if /^R$/ && $self->[2];
	}
}


package main;

# Construct the binary tree from example 1.
my $tree = BinaryTree->new(1,
		[2, 
			[4],
			[5,
				[6],
				[7],
			],
		],
		[3]);
dd $tree if $::verbose;

# Traverse the tree in different modes, where NLR solves this task.
foreach my $mode (qw(NLR LNR RNL LRN)) {
	my $list = LinkedList->new;
	$tree->traverse($mode, sub {
			# Need to take special care at the head node.
			$list ? $list->add($_)->next : $list->unshift($_)->head
		});
	dd $list if $::verbose;
	say "$mode: ", join ' -> ', $list->as_array;
}
