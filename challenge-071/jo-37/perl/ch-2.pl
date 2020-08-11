#!/usr/bin/perl

use strict;
use warnings;
use LinkedList::Single;

# Print the node data from a linked list.
sub list_print {
	my $list = shift;

	for ($list->head; $list->has_next; $list->next) {
		print $list->node_data->[0], " -> ";
	}
	print $list->node_data->[0], "\n"
}

# Remove n-th last element from the list.
sub remove_from_end {
	my ($list, $n) = @_;

	# Create a new singly linked list that will hold at most $n
	# "position pointers" into the original list.
	# The root node is special and is stored in the new
	# list's first node.
	my $record = LinkedList::Single->new($list->root_node);
	my $len = 1;

	# Process all nodes but the last from the original list.
	for ($list->head; $list->has_next; $list->next) {

		# Record the position.
		$record->push($list->node);

		# Discard the first recorded position if the maximum length
		# is exceeded.
		$record->shift if ++$len > $n;
	}

	# Retrieve the cut-node position from the first node of the record
	# list, reposition the original list and cut the next node.
	# If $n is large enough, the root_node is still the first node
	# of the record list causing the first node of the original list
	# to be cut.
	$list->node($record->head->node_data->[0]);
	$list->cut;

	$list;
}

my $L = 5;

for my $N (1 .. 6) {
	my $list = LinkedList::Single->new(1 .. $L);
	if ($N == 1) {
		print "List:\n";
		list_print $list;
	}
	print "N=$N\n";
	list_print remove_from_end $list, $N;
}
