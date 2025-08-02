#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 274 Task 2: Bus Route
#
#       Perl solution by Matthias Muth.
#

use v5.38;
use feature 'class';
no warnings 'experimental::class';

class BusRoute {
    field $frequency :param;
    field $offset    :param;
    field $duration  :param;

    method waiting_time( $now ) {
        return ( $offset - $now ) % $frequency;
    }

    method next_departure( $now ) {
        return $now + $self->waiting_time( $now );
    }

    method next_arrival( $now ) {
        return $self->next_departure( $now ) + $duration;
    }

    method as_string( @args ) {
        return ref( $self ) . "($frequency,$offset,$duration)";
    }
    use overload '""' => \&as_string;
}

our $verbose = 1;
sub vsay { say @_ if $verbose }

use List::Util qw( mesh min );

sub bus_route( $input ) {
    my @bus_routes =
        map BusRoute->new(
            mesh( [ qw( frequency offset duration ) ], $_ )
        ), $input->@*;

    my @results = ();
    for my $now ( 0..59 ) {
        vsay "$now:";
        vsay "    ", join " ",
            $_,
            "next departure", $_->next_departure( $now ),
            "next arrival",   $_->next_arrival( $now )
            for @bus_routes;

        # Get the next possible departure time.
        my $next_departure = min( map $_->next_departure( $now ), @bus_routes );

        # Of all the busses leaving at that time (there might be several of
        # them), we choose the one with the earliest arrival time.
        my $best_next_bus_arrival = min(
            map $_->next_arrival( $now ),
                grep $_->next_departure( $now ) == $next_departure,
                    @bus_routes );

        # Now find the best arrival time of any *later* bus.
        # Note that there might not be a 'later' bus if all 'next' busses leave
        # at the same time.
        my $best_later_bus_arrival = min(
            map $_->next_arrival( $now ),
                grep $_->next_departure( $now ) > $next_departure,
                    @bus_routes );
        vsay "    best next bus arrival: $best_next_bus_arrival";
        vsay "    best later bus arrival: ", $best_later_bus_arrival // "undef";

        # Add the current minute to the results if the later bus's arrival is
        # earlier than the best next bus's one.
        push @results, $now
            if defined $best_later_bus_arrival
                && $best_later_bus_arrival < $best_next_bus_arrival;
    }
    return \@results;
}

use Test2::V0 qw( -no_srand );
is bus_route( [[12, 11, 41], [15, 5, 35]] ), [36 .. 47],
    'Example 1: bus_route( [[12, 11, 41], [15, 5, 35]] ) == [36 .. 47]';
is bus_route( [[12, 3, 41], [15, 9, 35], [30, 5, 25]] ), [0 .. 3, 25, 26, 27, 40 .. 51, 55 .. 59],
    'Example 2: bus_route( [[12, 3, 41], [15, 9, 35], [30, 5, 25]] ) == [0 .. 3, 25, 26, 27, 40 .. 51, 55 .. 59]';
done_testing;
