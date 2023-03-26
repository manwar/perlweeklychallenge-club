#!/usr/bin/perl -s

use v5.16;
use warnings;
use Hash::PriorityQueue;
use experimental qw(signatures postderef);

# Create a new PriorityQueue object.
my $pq = PriorityQueue->new;

# Populate the queue with random priorities
$pq->push('1:1', 1);
$pq->push('1:0', 0);
$pq->push('2:1', 1);
$pq->push('2:0', 0);
$pq->push('1:-1', -1);
$pq->push('1:3', 3);

# Get the first item.
say $pq->shift;

# Continue populating.
$pq->push('1:2', 2);
$pq->push('3:1', 1);

# Default priority.
$pq->push('3:0');

# Retrieve all items.
say $pq->shift while $pq;;

# Can push anything onto the queue.
$pq->push(undef);
say "not empty" if $pq;
say $pq->shift // 'undef';

### Implementation

package PriorityQueue;
# Implementing the priority queue as a singly linked list of priority
# nodes.  Each node is an array of three elements:
# - the priority
# - a reference to an array of items
# - a reference to the next node.
# The priority queue itself is represented by a blessed ref to the first
# node.  Lower priorities come first, default is zero.

# Create a new object.
sub new ($class) {
    bless \my ($head), $class;
}

# Instead of is_empty, provide a Boolean value for the object signaling
# "not empty".
use overload 'bool' => sub ($self, @) {!!$$self};

# Push one item with given priority onto the queue.
sub push ($noderef, $item, $prio=0) {
    # Find the last node with a priority not larger than the given.
    for (; $$noderef && $$noderef->[0] <= $prio; $noderef = \$$noderef->[2]) {}

    # If there is no node for the given priority:
    # - Create a new node
    # - Link the successor of the last found node to this node
    # - Link the new node to the last found node
    $$noderef = [$prio, [], $$noderef]
        if !$$noderef || $$noderef->[0] != $prio;

    # Push the given item onto its corresponding node queue.
    push $$noderef->[1]->@*, $item;
}

sub shift ($noderef) {
    # Pick the first entry from the first node of the priority queue.
    my $item = shift $$noderef->[1]->@*;
    # Remove the leading node if it has become empty.
    $$noderef = $$noderef->[2] if !$$noderef->[1]->@*;

    $item;
}
