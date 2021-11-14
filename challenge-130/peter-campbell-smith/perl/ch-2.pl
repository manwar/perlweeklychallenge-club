#!/usr/bin/perl
use strict;
use warnings;

# PWC 130 task 2 - Peter Campbell Smith - 2021-09-14

# You are given a tree. Write a script to find out if the given tree is a Binary 
# Search Tree (BST).

# The solution shown below expects the input to be a
# file with one line per node, containing
#      node_id, node_key, node side, node_id_of_parent
# 'node_id' is a sequential number (starting from 0),
# 'node_side' is L or R and 'node_parent' is the node_id of the parent
# of the parent node. The first line is the node_id and key of the root node.

# Here is the sample tree (in __DATA__) shown as node_id->key
#
#                          0->50
#                 _____/           \_____
#           1->25                        2->75
#         /      \                     /       \ 
#    3->12        4->36          5->63           6->88
#   /    \       /     \        /      \       /       \
# 7->6  8->18  9->30 10->42  11->57  12->69  13->82  14->94

# The nodes in this code are not strictly the same as the nodes in
# the BST as defined by Wikipedia, as the Wikipedia nodes contain L and R
# downward pointers to the child level, whereas the nodes here contain upward 
# pointers to the parent level.

# To demonstrate a lowest leaf conflicting with the root, change the
# key of node 10 from 42 to 51.

our @nodes;

read_nodes();
check_nodes();

print qq[This is a valid binary search tree\n];

sub read_nodes {
	
	my ($n, $line, @keys, $junk);
	
	# read in tree
	$n = 0;
	while ($line = <DATA>) {
		@keys = split /[\s,]+/, $line;
		($nodes[$n]->{id}, $nodes[$n]->{key}, $nodes[$n]->{side}, $nodes[$n++]->{parent}) = @keys;
	}	
}

sub check_nodes {
	
	my ($node_id, $node, $key, $this_node, $parent);

	# loop over nodes
	for $node_id (1 .. $#nodes) {
		$node = $nodes[$node_id];
		$key = $node->{key};
		
		# need to check against every node back up to the root
		$this_node = $node;
		while (1) {
			$parent = $this_node->{parent};
			if ($this_node->{side} eq 'L') {
				is_bad(qq[node $node_id->$key > node $nodes[$parent]->{id}->$nodes[$parent]->{key}]) 
					if $key > $nodes[$parent]->{key};
			} elsif ($this_node->{side} eq 'R') {
				is_bad(qq[node $node_id->$key < node $nodes[$parent]->{id}->$nodes[$parent]->{key}]) 
					if $key < $nodes[$parent]->{key};
			} 
			last if $parent == 0;
			$this_node = $nodes[$parent];
		}
	}
}

sub is_bad {
	
	print qq[This is not a valid binary search tree as $_[0]\n];
	exit;
}

__DATA__
0, 50
1, 25,L,0
2, 75,R,0
3, 12,L,1
4, 36,R,1
5, 63,L,2
6, 88,R,2
7,  6,L,3
8, 18,R,3
9, 26,L,4
10,42,R,4
11,57,L,5
12,69,R,5
13,82,L,6
14,94,R,6
