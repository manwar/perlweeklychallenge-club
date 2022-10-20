#!/usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use Time::Piece;
use Time::Seconds qw{ ONE_DAY };

sub days_together ($schedule) {
    my @friends = keys %$schedule;
    for my $friend (@friends) {
        for (values %{ $schedule->{$friend} }) {
            $_ = 'Time::Piece'->strptime("2001-$_", '%Y-%d-%m');
        }
        die "Invalid date order"
            if $schedule->{$friend}{SD} > $schedule->{$friend}{ED};
    }

    @friends = reverse @friends
        if $schedule->{ $friends[0] }{SD} > $schedule->{ $friends[1] }{SD};

    my $finished_earlier
        = $schedule->{ $friends[0] }{ED} < $schedule->{ $friends[1] }{ED}
        ? 0 : 1;
    my $days = ($schedule->{ $friends[$finished_earlier] }{ED}
                - $schedule->{ $friends[1] }{SD})
               / ONE_DAY + 1;
    return $days >= 0 ? $days : 0
}

use Test2::V0;
plan 7;

is days_together({Foo => {SD => '12-01', ED => '20-01'},
                  Bar => {SD => '15-01', ED => '18-01'}}), 4, 'Example 1';

is days_together({Foo => {SD => '02-03', ED => '12-03'},
                  Bar => {SD => '13-03', ED => '14-03'}}), 0, 'Example 2';

is days_together({Foo => {SD => '02-03', ED => '12-03'},
                  Bar => {SD => '11-03', ED => '15-03'}}), 2, 'Example 3';

is days_together({Foo => {SD => '30-03', ED => '05-04'},
                  Bar => {SD => '28-03', ED => '02-04'}}), 4, 'Example 4';

is days_together({Foo => {SD => '13-03', ED => '13-03'},
                  Bar => {SD => '13-03', ED => '13-03'}}), 1, 'One day';

is days_together({Foo => {SD => '02-03', ED => '12-03'},
                  Bar => {SD => '18-03', ED => '24-03'}}), 0, 'Non adjacent 0';

my $e = dies { days_together({Foo => {SD => '12-01', ED => '11-01'}}) };
like $e, qr/Invalid date order/, 'Invalid order';
