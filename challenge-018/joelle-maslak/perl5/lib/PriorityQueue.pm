#!/usr/bin/env perl
use v5.22;
use strict;
use warnings;

package PriorityQueue;

use Moose;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;
use List::Util qw(max);

has 'priorities' => (
    is      => 'rw',
    isa     => 'HashRef',
    default => sub { {} },
);

has 'maxprio' => ( is => 'rw', );

sub is_empty($self) { return !keys $self->priorities->%* }

sub insert_with_priority ( $self, $elem, $priority ) {
    $self->priorities->{ +$priority } //= [];
    push $self->priorities->{ +$priority }->@*, $elem;

    if ( ( !defined( $self->maxprio ) ) or ( $priority > $self->maxprio ) ) {
        $self->maxprio( max keys $self->priorities->%* );
    }

    return;
}

sub pull_highest_priority_element($self) {
    my $elem = shift $self->priorities->{ $self->maxprio }->@*;

    if ( $self->priorities->{ $self->maxprio }->@* == 0 ) {
        delete $self->priorities->{ $self->maxprio };
        $self->maxprio( max keys $self->priorities->%* );
    }

    return $elem;
}

1;

