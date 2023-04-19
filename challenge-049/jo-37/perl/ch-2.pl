#!/usr/bin/perl

use v5.16;
use warnings;
use experimental 'signatures';


### Input and Output

my $lru = LRU->new(3);
say "cache: (@{$lru->keys})";
$lru->set(1, 3);
say "cache: (@{$lru->keys})";
$lru->set(2, 5);
say "cache: (@{$lru->keys})";
$lru->set(3, 7);
say "cache: (@{$lru->keys})";
say "get(2): ",$lru->get(2);
say "cache: (@{$lru->keys})";
say "get(1): ", $lru->get(1);
say "get(4): ", $lru->get(4) // 'undef';
say "cache: (@{$lru->keys})";
$lru->set(4, 9);
say "cache: (@{$lru->keys})";
say "get(3): ",$lru->get(3) // 'undef';


### Implementation

package LRU;

# One desired property of a cache implementation is a time complexity of
# O(1) for set and get operations.  This requires a special data
# structure:
# - a hash to locate a cached item
# - some kind of list to maintain the "recently used" order.
# A hash lookup already has O(1).  Adding an item to the end of a list can
# easily achieved in O(1), too.  Removing an item from an arbitrary
# position in a list can be done in O(1) in a doubly linked list.  This
# leads to a hash with the cache keys as keys and the nodes of the
# doubly linked list as values.  Each node is an array holding this
# data:
# node->[0]: cache key
# node->[1]: cache value
# node->[2]: previous node
# node->[3]: next node
# The cache key is required to be able to delete a hash key when a node
# is dropped.

sub new ($class, $capacity) {
    # A LRU object consists of a maximum capacity, the current level, a
    # hash from cache keys to list nodes and two pseudo-nodes head and
    # tail that point to the first and last element of the list.
    my $self = {capacity => $capacity, fill => 0, data => {}, head => [],
        tail => []};
    ($self->{head}[3], $self->{tail}[2]) = ($self->{tail}, $self->{head});
    bless $self, $class;
}

# Set a cache value.
sub set ($self, $key, $value) {
    my $node = $self->{data}{$key};
    # If the cache key does not exist, create a new node, append it to
    # the end of the list and add its cache key to the map.
    if (!$node) {
        # If the cache is full, drop the least recently used item.
        if($self->{fill} == $self->{capacity}) {
            my $lru = $self->{head}[3];
            ($self->{head}[3], $lru->[3][2]) = ($lru->[3], $self->{head});
            delete $self->{data}{$lru->[0]};
            $self->{fill}--;
        }
        my $node = [$key, $value, $self->{tail}[2], $self->{tail}];
        $node->[2][3] = $node->[3][2] = $node;
        $self->{data}{$key} = $node;
        $self->{fill}++;
    } else {
        # Otherwise move the modified node to the end of the list.
        ($node->[2][3], $node->[3][2]) = ($node->[3], $node->[2]);
        $self->{tail}[3] = $node;
        $node->[1] = $value;
    }
}

# Get a cache value.
sub get ($self, $key) {
    my $node = $self->{data}{$key};
    return unless defined $node;

    # Remove the node from the list and append it to the end.
    ($node->[2][3], $node->[3][2], $node->[2], $node->[3])
        = ($node->[3], $node->[2], $self->{tail}[3]);
    $self->{tail}[2] = $self->{tail}[2][3] = $node;

    # The cache value.
    $node->[1];
}


# Return the cache keys in recently used order.
sub keys ($self) {
    my @keys;
    for (my $node = $self->{head}[3]; $node; $node = $node->[3]) {
        # Skip pseudo nodes.
        next unless defined $node->[0];
        push @keys, $node->[0];
    }
    \@keys;
}
