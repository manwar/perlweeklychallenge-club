#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub no_connection($routes) {
    # Calculate a list of origins (first value) and destinations (second value)
    my @origins      = map { $_->[0] } @$routes;
    my @destinations = map { $_->[1] } @$routes;

    # Find route destinations that aren't also an origin
    my @dead_ends = grep {
        my $c = $_;
        ! grep { $c eq $_ } @origins
    } @destinations;

    if ( $#dead_ends > 0 ) {
        die "There are multiple routes with no outgoing connection\n";
    }

    if ( $#dead_ends == -1 ) {
        die "All routes have an outgoing connection\n";
    }

    return $dead_ends[0];
}

sub main (@args) {
    # Convert input into pairs. The first value is the start of route.
    # The second value is the destination
    my @routes = ();
    for ( my $i = 0 ; $i <= $#args ; $i += 2 ) {
        push @routes, [ $args[$i], $args[ $i + 1 ] ];
    }
    say no_connection( \@routes );
}

main(@ARGV);