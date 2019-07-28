#!/usr/bin/env perl

=for comment

Write a script to implement Priority Queue. It is like regular queue except each
element has a priority associated with it. In a priority queue, an element with
high priority is served before an element with low priority. Please check this
wiki page for more informations. It should serve the following operations:

1) is_empty: check whether the queue has no elements.

2) insert_with_priority: add an element to the queue with an associated
priority.

3) pull_highest_priority_element: remove the element from the queue that has the
highest priority, and return it. If two elements have the same priority, then
return element added first.

=cut

package Queue::Priority;
use v5.24;
use strict;
use warnings;
use feature qw(signatures);
no warnings "experimental::signatures";
use Scalar::Util qw(looks_like_number);
use List::Util qw(max);
use Carp;

sub new {
    my $class = shift;
    $class = ref $class if ref $class;
    my $self = bless { queue => {} }, $class;
    $self;
}

sub is_empty {
    return !( shift->{queue}->%* );
}

sub insert_with_priority ( $self, $elem, $p = -1 ) {
    croak "Error: second argument (priority) must be a number. Given: $p"
        unless looks_like_number($p);

    push $self->{queue}->{$p}->@*, $elem;
}

sub pull_highest_priority_element {
    my $self = shift;
    my $high = max keys $self->{queue}->%*;
    return undef unless $high;

    my $pulled = shift $self->{queue}->{$high}->@*;
    delete $self->{queue}->{$high} if $self->{queue}->{$high}->@* == 0;
    return $pulled;
}

sub peek {
    my $self = shift;
    my $high = max keys $self->{queue}->%*;
    return undef unless $high;

    return $self->{queue}->{$high}->[0];
}

sub print {
    my $self = shift;
    say "Queue is empty" if $self->is_empty;
    for my $k ( sort { $b <=> $a } keys $self->{queue}->%* ) {
        printf "%5d => %s\n", $k, join( ", ", $self->{queue}->{$k}->@* );
    }
}

1;

package main;

use v5.24;
use strict;
use warnings;
use Test::More tests => 9;

my $queue = Queue::Priority->new;
ok( $queue->is_empty, "Queue is empty" );

$queue->insert_with_priority( 2, 8 );
$queue->insert_with_priority(5);
$queue->insert_with_priority( 10,        3 );
$queue->insert_with_priority( 2.78,      3 );
$queue->insert_with_priority( "Element", 10 );
$queue->print;

ok( !$queue->is_empty, "Queue is not empty" );
my $highest = $queue->pull_highest_priority_element;
is( $highest, "Element", "Next highest element is 'Element'" );
$highest = $queue->pull_highest_priority_element;
is( $highest, 2, "Next highest element is '2'" );
$highest = $queue->pull_highest_priority_element;
is( $highest,       10,   "Next highest element is '10'" );
is( $queue->peek(), 2.78, "Peek shows next highest element is '2.78'" );
$highest = $queue->pull_highest_priority_element;
is( $highest, 2.78, "Next highest element is '2.78'" );
$highest = $queue->pull_highest_priority_element;
is( $highest, 5, "Next highest element is '5'" );
$highest = $queue->pull_highest_priority_element;
ok( !$highest, "No more elements in queue" );
