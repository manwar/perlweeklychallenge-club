#!/usr/bin/env perl

use feature qw{say state signatures};
use strict;
use warnings;
use utf8;
no warnings qw{ experimental };

my @examples;
push @examples,
    {
    arrivals   => [ '11:20', '14:30' ],
    departures => [ '11:50', '15:00' ],
    };

push @examples,
    {
    arrivals   => [ '10:20', '11:00', '11:10', '12:20', '16:20', '19:00' ],
    departures => [ '10:30', '13:20', '12:40', '12:50', '20:20', '21:20' ],
    };

for my $e (@examples) {
    my $min_platforms = min_platforms($e);
    my $arrivals      = join ', ', $e->{arrivals}->@*;
    my $departures    = join ', ', $e->{departures}->@*;
    say <<"END";
    Input: \@arrivals   = ($arrivals)
    Input: \@departures = ($departures)
    Output: $min_platforms
END
}

sub min_platforms ($timetable) {
    my $p  = 0;
    my $mp = 0;
    my @arrivals =
        map { s/\D//g; $_ }
        map { $_ }
        sort $timetable->{arrivals}->@*;
    my @departures =
        map { s/\D//g; $_ }
        map { $_ }
        sort $timetable->{departures}->@*;

    my $first = $arrivals[0];
    my $last  = $departures[-1];
    for my $t ( $first .. $last ) {
        if ( @arrivals && $t == $arrivals[0] ) {
            shift @arrivals;
            $p++;
            $mp = $p if $p > $mp;
        }
        if ( @departures && $t == $departures[0] ) {
            shift @departures;
            $p--;
        }
    }

    return $mp;
}

