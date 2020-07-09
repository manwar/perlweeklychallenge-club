#!/usr/bin/perl

use strict;
use warnings;

use LinkedList::Single;

sub list_zip;
sub list_reverse;
sub list_halve;

# Reorder list according to challenge #2.
#
# At first glance the expensive "pop" operation seems to be required
# for this task, but actually it isn't.
 
sub list_reorder {
	my $list = shift;
	list_zip $list, list_reverse list_halve $list;
}

# Split list in two (around the middle) with a larger leading part.
sub list_halve {
	my $list = shift;

	# Count the length of the list.
	my $length = 0;
	for ($list->head; $list->has_next; $list->next) {
		$length++;
	}

	# Advance to the middle of the list.
	$list->head;
	for (my $i = 0; 2 * $i < $length; $i++) {
		$list->next;
	}

	# Splice off and return the trailing part.
	$list->splice(int($length / 2));
}

# Reverse list.
sub list_reverse {
	my $list = shift;

	# Seek to the last node and count the length.
	my $length = 0;
	for ($list->head; $list->has_next; $list->next) {
		$length++;
	}

	# Move leading nodes one by one from the head straight after
	# the (former) last node.
	$list->add($list->shift) while $length--;

	$list;
}

# Merge two lists one by one.
sub list_zip {
	my ($first, $second) = @_;

	# Remove node from the head of the second list and add it at
	# the current position of the first list.  Then skip over
	# the newly added node and the next node of the first list.
	$first->head;
	$second->head;
	$first->add($second->shift)->next->next while !$second->is_empty;

	$first;
}

# Generate a linked list containing numbered nodes.
sub list_gen {
	my ($id, $count) = @_;

	LinkedList::Single->new(map [$id, $_], (1 .. $count));
}

# Print node data from linked list.
sub list_print {
	my ($label, $list) = @_;

	local $" = '';
	print "$label:\t";
	for ($list->head; $list->has_next; $list->next) {
		print "@{$list->node_data->[0]} -> ";
	}
	print "@{$list->node_data->[0]}\n";
}

# main

# Some examples.
for my $length (3 .. 8) {
	my $list = list_gen 'n', $length;
	list_print 'orig', $list;
	list_reorder $list;
	list_print 'reord', $list;
	print "\n";
}
