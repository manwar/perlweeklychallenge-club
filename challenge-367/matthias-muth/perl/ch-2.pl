#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 367 Task 2: Conflict Events
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub conflict_events( $event1, $event2 ) {
    my @times =
        map { /^(\d+):(\d+)/; $1 * 60 + $2 } $event1->@*, $event2->@*;
    $times[1] += 24 * 60
        if $times[1] < $times[0];
    $times[3] += 24 * 60
        if $times[3] < $times[2];
    return $times[0] < $times[3] && $times [1] > $times[2]
        || $times[0] + 24 * 60 < $times[3] && $times [1] + 24 * 60 > $times[2]
        || $times[0] < $times[3] + 24 * 60 && $times [1] > $times[2] + 24 * 60;
}

use Test2::V0 qw( -no_srand );

is conflict_events( ["10:00", "12:00"], ["11:00", "13:00"] ), T,
    'Example 1: conflict_events( ["10:00", "12:00"], ["11:00", "13:00"] ) is true';
is conflict_events( ["09:00", "10:30"], ["10:30", "12:00"] ), F,
    'Example 2: conflict_events( ["09:00", "10:30"], ["10:30", "12:00"] ) is false';
is conflict_events( ["14:00", "15:30"], ["14:30", "16:00"] ), T,
    'Example 3: conflict_events( ["14:00", "15:30"], ["14:30", "16:00"] ) is true';
is conflict_events( ["08:00", "09:00"], ["09:01", "10:00"] ), F,
    'Example 4: conflict_events( ["08:00", "09:00"], ["09:01", "10:00"] ) is false';
is conflict_events( ["23:30", "00:30"], ["00:00", "01:00"] ), T,
    'Example 5: conflict_events( ["23:30", "00:30"], ["00:00", "01:00"] ) is true';
is conflict_events( ["00:00", "01:00"], ["23:30", "00:30"] ), T,
    'Own Test 1: conflict_events( ["00:00", "01:00"], ["23:30", "00:30"] ) is true';

done_testing;
