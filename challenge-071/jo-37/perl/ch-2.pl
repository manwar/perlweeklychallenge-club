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
	# "position pointers" into the original list.  'undef' is used
	# as a pseudo-pointer referencing the original list's first node
	# and is stored in the new list's first node.
	my $record = LinkedList::Single->new(undef);
	my $len = 1;

	# Process all nodes but the last from the original list.
	for ($list->head; $list->has_next; $list->next) {

		# Record the position and skip over the new node.
		$record->add($list->node)->next;

		# Discard the first recorded position if the maximum length
		# is exceeded.
		$record->shift if ++$len > $n;
	}

	# Retrieve the cut-node position from the first node of the record
	# list, reposition the original list and cut the next node or
	# remove the first node.
	# Note: "cut" removes the next node after the current and thus
	# cannot be used to remove the first node, where a "shift" is
	# required.
	my $node = $record->head->node_data->[0];
	if ($node) {
		$list->node($node);
		$list->cut;
	} else {
		$list->shift;
	}

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
