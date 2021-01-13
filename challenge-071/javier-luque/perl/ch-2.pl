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

sub remove_node {
	my ($self, $n) = @_;

	# Loop through the nodes
	my $node = $self->first;

	# find total nodes
	my $total = 0;
	while ($node) {
		$node = $node->next;
		$total++;
	}

	# Get the real location
	# relative to the first node
	$n = ($n - 1) % $total;
	$n = $total - $n - 1;

	# Initialize for node removal
	my $i = 0;
	my $last_node;
	$node = $self->first;

	# Process each node
	while ($node && $i <= $n) {
		if ($i == $n) {
			# First node
			($last_node) ?
				$last_node->next($node->next) :
				$self->first($node->next);

			# Next node
			$node->next( ($node->next) ? $node->next->next : undef);
			last;
		}

		$last_node = $node;
		$node = $node->next;
		$i++;
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

# Create lists and remove node
for my $i (1..6) {
	my $ll = LinkedList->new();
	$ll->create_list(1,2,3,4,5);
	say 'When $N = ' . $i;
	$ll->remove_node($i);
	say 'Output: ' . $ll->display_list;
}
