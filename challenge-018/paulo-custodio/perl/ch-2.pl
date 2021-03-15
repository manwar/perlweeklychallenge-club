#!/usr/bin/perl

# Challenge 018
#
# Task #2
# Write a script to implement Priority Queue. It is like regular queue except
# each element has a priority associated with it. In a priority queue, an
# element with high priority is served before an element with low priority.
# Please check this wiki page for more informations. It should serve the
# following operations:
#
# is_empty: check whether the queue has no elements.
# insert_with_priority: add an element to the queue with an associated priority.
# pull_highest_priority_element: remove the element from the queue that has the
# highest priority, and return it. If two elements have the same priority,
# then return element added first.

use strict;
use warnings;
use 5.030;

# implement a Priority-queue as an ordered list of [priority, list of elements]
{
    package PQueue;

    sub new {
        my($class) = @_;
        return bless [], $class;
    }

    sub is_empty {
        my($self) = @_;
        return @$self == 0;
    }

    sub insert {
        my($self, $pri, $elem) = @_;
        if ($self->is_empty) {                  # special case: empty
            push @{$self}, [$pri, [$elem]];
        }
        elsif ($pri < $self->[0][0]) {          # special case: lowest
            unshift @{$self}, [$pri, [$elem]];
        }
        elsif ($pri > $self->[-1][0]) {         # special case: highest
            push @{$self}, [$pri, [$elem]];
        }
        else {
            for my $i (0 .. $#{$self}) {        # traverse list, search for position
                if ($self->[$i][0] == $pri) {   # same priority
                    push @{$self->[$i][1]}, $elem;
                    return;
                }
                elsif ($self->[$i][0] > $pri) { # higher
                    splice @$self, $i, 0, [$pri, [$elem]];
                    return;
                }
            }
            die "not reached";
        }
    }

    sub pull {
        my($self) = @_;
        return if $self->is_empty;
        my $elem = shift @{$self->[-1][1]};
        if (@{$self->[-1][1]}==0) {             # bucket now empty
            pop @$self;
        }
        return $elem;
    }
}

use Test::More;
my $q = PQueue->new;

ok $q->is_empty, "is empty";
ok !defined($q->pull), "pull from empty queue";

# insert same priority
$q->insert(1, 123);
ok !$q->is_empty, "is not empty";

$q->insert(1, 456);
ok !$q->is_empty, "is not empty";

$q->insert(1, 789);
ok !$q->is_empty, "is not empty";

# pull
is $q->pull, 123, "got element";
ok !$q->is_empty, "is not empty";

is $q->pull, 456, "got element";
ok !$q->is_empty, "is not empty";

is $q->pull, 789, "got element";
ok $q->is_empty, "is empty";

# insert higher priority
$q->insert(1, 123);
$q->insert(1, 456);
$q->insert(2, 23);
$q->insert(3, 4);

# insert lower priority
$q->insert(0, 999);
$q->insert(0, 998);

is $q->pull, 4, "got element";
is $q->pull, 23, "got element";
is $q->pull, 123, "got element";
is $q->pull, 456, "got element";
is $q->pull, 999, "got element";
is $q->pull, 998, "got element";
ok $q->is_empty, "is empty";

done_testing;
