#!/usr/bin/perl
# Test: ./ch-2.pl
package LinkedList::Node; # Linked list
use Mouse;

has 'value' => (
	is  => 'rw',
	isa => 'Maybe[Int]',
	default => sub {
		return undef;
	}
);

has 'next' => (
	is  => 'rw',
	isa => 'Maybe[LinkedList::Node]',
	default => sub {
		return undef
	}
);

__PACKAGE__->meta->make_immutable();

package LinkedList;

use Mouse;
use feature qw /say/;
use LinkedList::Node;

has 'first'  => (
	is  => 'rw',
	isa => 'Maybe[LinkedList::Node]',
	default => sub {
		return undef
	}
);

# Create the list
sub create_list {
	my ($self, @values) = @_;
	my $prev_node;

	# Populate the list
	for my $value (@values) {
		my $node = LinkedList::Node->new(value => $value);

		# Populate first and next nodes
		($prev_node) ?
			$prev_node->next($node) :
			$self->first($node);

		# Next
		$prev_node = $node;
	}
}

sub reorder_list {
	my ($self, $k) = @_;

	# Loop through the nodes
	my $node = $self->first;

	# Process each node
	while ($node) {
		my $next_node = $node->next;
		my $traverse_node = $node;
		my $last_node = $node;

		# Traverse Linked list
		while ($traverse_node->next) {
			$last_node = $traverse_node;
			$traverse_node = $traverse_node->next;
		}

		$node->next($traverse_node);

		if ($next_node && $next_node->next) {
			$traverse_node->next($next_node);
			$last_node->next(undef);
		} else {
			$traverse_node->next(undef);
		}

		$node = $next_node;
	}
}

sub display_list {
	my $self = shift;

	my $node = $self->first;
	my @keys;

	while ($node) {
		push @keys, $node->value;
		$node = $node->next;
	}

	return join ' → ', @keys;
}

__PACKAGE__->meta->make_immutable();

package main;

use Modern::Perl;
use LinkedList;

my $ll = LinkedList->new();
$ll->create_list(1,2,3,4);
say 'Before: ' . $ll->display_list;
$ll->reorder_list();
say 'After: ' . $ll->display_list;
