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

    # Temp variables to store node locations
    my $k_node_current;
    my $k_node_first;
    my $before_node_current;
    my $before_node_first;
    my $after_node_current;
    my $after_node_first;

    # Loop through the nodes
    my $node = $self->first;
    while ($node) {
    	if ($node->value == $k) {
    		if ($k_node_current) {
    			$k_node_current->next($node);
    			$k_node_current = $node;
    		} else {
    			$k_node_first   = $node;
    			$k_node_current = $node;
    		}
    	}

    	# Process the nodex lower than k
    	if ($node->value < $k) {
    		if ($before_node_current) {
    			$before_node_current->next($node);
    			$before_node_current = $node;
    		} else {
    			$before_node_first   = $node;
    			$before_node_current = $node;
    		}
    	}

    	# Process the nodex higher than k
    	if ($node->value > $k) {
    		if ($after_node_current) {
    			$after_node_current->next($node);
    			$after_node_current = $node;
    		} else {
    			$after_node_first   = $node;
    			$after_node_current = $node;
    		}
    	}

    	$node = $node->next;
    }

    # link the chains
    $self->first($before_node_first);
    $before_node_current->next($k_node_first);
    $k_node_current->next($after_node_first);
    $after_node_current->next(undef);
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


