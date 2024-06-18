#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

use List::Util qw{ first };
use JSON;

my $j    = JSON->new->canonical->space_after;
my @examples = (

    [ [ 12, 11, 41 ], [ 15, 5, 35 ] ],
    [ [ 12, 3,  41 ], [ 15, 9, 35 ], [ 30, 5, 25 ] ],
);

for my $example (@examples) {
    my $routes = best_route( $example->@* );
    my $input  = $j->encode($example);
    my $output = $j->encode($routes);

    say <<"END";
Input:  $input
Output: $output
END
}

sub best_route (@routes) {
    my @starts;
    my @route_ids;
    my @timetable;

    my $r = 0;
    for my $route (@routes) {
        $r++;
        push @route_ids, $r;
        my ( $interval, $start, $duration ) = $route->@*;
        my $i     = 0;
        my $stime = 0;
        while ( $stime < 60 ) {
            $stime = $start + ( $interval * $i );
            my $etime = $stime + $duration;
            my $bus   = {
                route => $r,
                home  => $stime,
                dest  => $etime,
            };
            push @timetable, $bus;
            $i++;
        }
    }

    @timetable = sort { $a->{home} <=> $b->{home} } @timetable;

    for my $t ( 0 .. 59 ) {
        my @next;
        for my $r (@route_ids) {
            my ($next) = grep { $t <= $_->{home} }
                grep { $_->{route} == $r } @timetable;
            push @next, $next;
        }

        my ($next_bus) =
            sort { $a->{home} <=> $b->{home} } @next;
        my ($best_bus) =
            sort { $a->{dest} <=> $b->{dest} } @next;

        my $next_bus_route = $next_bus->{route};
        my $best_bus_route = $best_bus->{route};

        my $next_bus_home = $next_bus->{home};
        my $best_bus_home = $best_bus->{home};

        my $same = 0;
        if ( $next_bus_route == $best_bus_route ) { $same = 1 }
        if ( $next_bus_home == $best_bus_home )   { $same = 1 }

        push @starts, int $t if !$same;
    }

    return \@starts;
}
