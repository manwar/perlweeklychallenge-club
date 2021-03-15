#!/usr/bin/perl -s

use v5.16;
use warnings FATAL => 'all';
no warnings 'recursion';
use experimental qw(postderef signatures);
use Data::Dump;

our ($mode, $examples, $verbose);
$mode ||= 'NLR';

run_examples() if $examples; # does not return

say(<<EOS), exit unless @ARGV;
usage: $0 [-examples] [-verbose] [-mode=MODE] [node ...]

-examples
    run examples from challenge

-verbose
    print diagnostic information

-mode=MODE
    select traversal mode, any permutation of N, L, R. Default: NLR
    see: 
    https://en.wikipedia.org/wiki/Tree_traversal#Depth-first_search_of_binary_tree
    

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
    ROOT:1:n2:n3 n2:2:n4:n5 n3:3 n4:4 n5:5:n6:n7 n6:6 n7:7
EOS

# @ARGV to BinaryTree
my $tree = build_tree(@ARGV);
dd $tree if $verbose;

my $list = LinkedList->new;

# Convert
flatten_tree($tree, $list, $mode);
dd $list if $verbose;

# Format output
say "$mode: ", join ' -> ', $list->as_array;

# Build a binary tree from the given list of nodes
sub build_tree {
    # capture nodes
    my %nodes = map {
        my ($key, %val); ($key, @val{qw(val left right)}) = split /:/;
        ($key => \%val)
    } @_;
    dd %nodes if $verbose;

    # dynamically build the tree from the given nodes while traversing
    my $tree = BinaryTree->new('ROOT');
    $tree->traverse('NLR', sub {
        my %node = $nodes{$_->[0]}->%*;
        $_->[0] = $node{val};
        $_->[1] = [$node{left}] if $node{left};
        $_->[2] = [$node{right}] if $node{right};
    });

    $tree;
}

# The "glue" for this task: traverse given binary tree and build a
# linked list from the visited nodes.
sub flatten_tree ($tree, $list, $mode) {
    $tree->traverse($mode, sub {
            # Need to take special care at the head node.
            $list ? $list->add($_->[0])->next :
            $list->unshift($_->[0])->head
        });
}

sub run_examples {
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
    dd $tree if $verbose;

    # Traverse the tree in different modes, where NLR solves this task.
    foreach my $mode (qw(NLR LNR RNL LRN)) {
        my $list = LinkedList->new;
        flatten_tree($tree, $list, $mode);
        dd $list if $verbose;
        say "$mode: ", join ' -> ', $list->as_array;
    }
    exit;
}


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
# processing order with $_ set to the current node.
sub traverse ($self, $mode, $code) {
    # Recursively process the tree in the specified order.  Nodes are
    # not blessed and thus have no methods.
    foreach (split //, $mode) {
        do {local $_ = $self; $code->()} if /^N$/;
        traverse($self->[1], $mode, $code) if /^L$/ && $self->[1];
        traverse($self->[2], $mode, $code) if /^R$/ && $self->[2];
    }
}
