#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

{   my $DAY = minutes(24, 0);

    sub conflict_events($event1, $event2) {
        my $e1 = [map split(/:/), @$event1];
        my $e2 = [map split(/:/), @$event2];
        for my $e ($e1, $e2) {
            $e->[2] += 24 if minutes(@$e[0, 1]) > minutes(@$e[2, 3]);
        }

        my %m;
        undef $m{ $_ % $DAY }{1} for minutes(@$e1[0, 1]) .. minutes(@$e1[2, 3]);
        undef $m{ $_ % $DAY }{2} for minutes(@$e2[0, 1]) .. minutes(@$e2[2, 3]);
        my @overlap = grep exists $m{$_}{1} && exists $m{$_}{2}, keys %m;

        # Special case: e2 starts when e1 ends and vice versa.
        return if 2 == @overlap && $e1->[0] % 24 == $e2->[2] % 24
                                && $e1->[2] % 24 == $e2->[0] % 24
                                && $e1->[1] == $e2->[3]
                                && $e1->[3] == $e2->[1];
        return @overlap > 1
    }
}

sub minutes($h, $m) { $h * 60 + $m }

use Test2::V0;
plan(5 + 6);
use constant {true => bool(1),
              false => bool(0)};

is conflict_events(['10:00', '12:00'], ['11:00', '13:00']), true, 'Example 1';
is conflict_events(['09:00', '10:30'], ['10:30', '12:00']), false, 'Example 2';
is conflict_events(['14:00', '15:30'], ['14:30', '16:00']), true, 'Example 3';
is conflict_events(['08:00', '09:00'], ['09:01', '10:00']), false, 'Example 4';
is conflict_events(['23:30', '00:30'], ['00:00', '01:00']), true, 'Example 5';

is conflict_events(['00:00', '01:00'], ['23:30', '00:30']), true,
    'e2 starts first';
is conflict_events(['12:00', '14:00'], ['12:00', '12:30']), true, 'same start';
is conflict_events(['12:00', '14:00'], ['13:00', '14:00']), true, 'same end';
is conflict_events(['12:00', '14:00'], ['12:30', '13:30']), true, 'inside';
is conflict_events(['23:57', '00:02'], ['22:02', '23:58']), true, 'midnight';
is conflict_events(['22:00', '10:00'], ['10:00', '22:00']), false, 'full day';
