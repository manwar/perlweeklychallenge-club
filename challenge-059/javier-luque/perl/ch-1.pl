#!/usr/bin/perl
# Test: ./ch-1.pl
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

sub partition_list {
    my ($self, $k) = @_;

    # Loop through the nodes
    my $node = $self->first;
    my $passed_k = 0;
    my $prev_node;
    my $k_node;

    while ($node) {
    	my $next_node = $node->next;
    	my $moved_node = 0;

    	if ($node->value < $k && $passed_k) {
    		my $traverse_node = $self->first;
    		while ($traverse_node->next->value < $node->value) {
    			$traverse_node = $traverse_node->next;
    		}
    		$prev_node->next($node->next);
    		$node->next($traverse_node->next);
    		$traverse_node->next($node);
    		$moved_node = 1;
    	}

    	# Other k's
    	if ($node->value == $k && $passed_k) {
    		my $temp = $k_node->next;
    		$prev_node->next($node->next);
    		$k_node->next($node);
    		$node->next($temp);
    		$moved_node = 1;
    	};

    	# First k encountered
    	if ($node->value == $k && !$passed_k) {
    		$passed_k = 1;
    		$k_node = $node;
    	};

    	# The prev node pointer only changes if we
    	# didn't move the node
    	$prev_node = $node unless ($moved_node);

    	# Next node
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

use strict;
use warnings;
use LinkedList;

my $ll = LinkedList->new();
$ll->create_list(1,4,3,2,5,2);
say 'Before: ' . $ll->display_list;
$ll->partition_list(3);
say 'After: ' . $ll->display_list;

say "\nDuplicate k's";
$ll->create_list(1,4,3,2,5,2,3);
say 'Before: ' . $ll->display_list;
$ll->partition_list(3);
say 'After: ' . $ll->display_list;
