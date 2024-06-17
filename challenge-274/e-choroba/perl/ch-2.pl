#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ min };

use enum qw( INTERVAL OFFSET DURATION );

sub bus_route(@routes) {
    my %at;
    for my $route (@routes) {
        my $minute = $route->[OFFSET];
        while ($minute <= 120) {
            undef $at{$minute}{ $minute + $route->[DURATION] };
            $minute += $route->[INTERVAL];
        }
    }
    my @let_leave;
    my $previous = 0;
    for my $minute (0 .. 120) {
        if (exists $at{$minute}) {
            my $best = min(keys %{ $at{$minute} });
            my $i = 1;
            ++$i while $minute + $i < 120 && ! exists $at{ $minute + $i };
            if ($minute + $i < 120) {
                my $best2 = min(keys %{ $at{ $minute + $i } });
                if ($best2 < $best) {
                    push @let_leave, $previous .. min(59, $minute);
                }
            }
            $previous = $minute + 1;
        }
    }
    return \@let_leave
}

use Test2::V0;
plan 2 + 2;

is bus_route([12, 11, 41], [15, 5, 35]),
    [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47],
    'Example 1';

is bus_route([12, 3, 41], [15, 9, 35], [30, 5, 25]),
    [0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49,
     50, 51, 55, 56, 57, 58, 59],
    'Example 2';

is bus_route([30, 0, 10], [31, 1, 9]), [], 'Arrival at the same time';

is bus_route([30, 0, 10], [30, 0, 8], [30, 1, 8]), [],
    'Alternative trumps only one bus';
