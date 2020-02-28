#!/usr/bin/perl
# Test: ./ch-2.pl 3
package LL::Node; # Linked list

use Mouse;

has 'key' => (
    is  => 'rw',
    isa => 'Int',
    default => sub {
        return undef;
    }
);

has 'value' => (
    is  => 'rw',
    isa => 'Str',
    default => sub {
        return undef;
    }
);

has 'next' => (
    is  => 'rw',
    isa => 'Maybe[LL::Node]',
    default => sub {
        return undef
    }
);

has 'prev' => (
    is  => 'rw',
    isa => 'Maybe[LL::Node]',
    default => sub {
        return undef
    }
);


__PACKAGE__->meta->make_immutable();

package Cache::LRU; # LRU Cache

use Mouse;
use feature qw /say/;
use LL::Node;

has 'max_capacity' => (
    is  => 'rw',
    isa => 'Int',
    default => sub {
        return 3;
    }
);

has 'capacity' => (
    is  => 'rw',
    isa => 'Int',
    default => sub {
        return 0;
    }
);

has 'positions' => (
    is  => 'rw',
    isa => 'HashRef',
    default => sub {
        return {}
    }
);

has 'last'  => (
    is  => 'rw',
    isa => 'Ref',
);


has 'first'  => (
    is  => 'rw',
    isa => 'Ref',
);



sub set {
    my ($self, $key, $value) = @_;

    # New node
    my $new_node = LL::Node->new(
        key => $key, value => $value
    );

    # Push out 1 if at capacity
    if ($self->capacity >= $self->max_capacity) {
        my $node_to_kill = $self->first;
        $self->first($self->first->next);
        delete $self->positions->{$node_to_kill->key};
        $self->capacity($self->capacity - 1);
    }

    # Set the first and last reference to the new node
    if ( $self->first ) {
        $self->last->next($new_node);
        $new_node->prev($self->last);
    } else {
        $self->first($new_node);
    }

    # Last node
    $self->last($new_node);

    # Store the position
    $self->positions->{$key} = $new_node;

    # Increment capacity
    $self->capacity($self->capacity + 1);

    say "Setting: ($key, $value)" . $self->show_nodes;
}


sub get {
    my ($self, $key) = @_;

    my $node = $self->positions->{$key};

    # Cache miss
    unless ($node) {
        say "Getting: ($key) - cache miss" .
            $self->show_nodes;

        # Return the cache miss -1
        return -1;
    }

    # This might be the first node
    if ($node->prev) {
        $node->prev->next($node->next)
    } else {
        $self->first($node->next);
    }

    # Change this node previous to last
    $node->prev($self->last);

    # Set the last's next to this node
    $self->last->next($node);

    # clear the node's next as it will be last
    $node->next(undef);

    # Set to LRU last pointer to this
    $self->last($node);

    # Get the value
    my $value = $node->value;

    say "Getting: ($key) Value: $value)" . $self->show_nodes;
    return $node->value;
}



sub show_nodes {
    my $self = shift;
    my @keys;

    my $node = $self->first;

    while ($node) {
        push @keys, $node->key;
        $node = $node->next;
    }

    return " [LRU] - " . (join ',', @keys) . " - [MRU]";
}


__PACKAGE__->meta->make_immutable();

package main;

use strict;
use warnings;
use Cache::LRU;

my $max_capacity = my $number = join '', @ARGV;
my $cache = Cache::LRU->new(max_capacity => $max_capacity || 3);

$cache->set(1, 3);
$cache->set(2, 5);
$cache->set(3, 7);
$cache->get(2);      # returns 5
$cache->get(1);      # returns 3
$cache->get(4);      # returns -1
$cache->set(4, 9);
$cache->get(3);      # returns -1
