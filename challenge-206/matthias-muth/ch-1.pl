#!/usr/bin/env perl

use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use List::Util qw( min );

sub time_diffs( @t ) {
    map { my $d = abs( $t[0] - $t[$_] ); min( $d, (24*60) - $d ); } 1..$#t;
}

sub shortest_time( @hhmm_times ) {
    my @t = map { /^(\d+):(\d{2})$/; $1 * 60 + $2 } @hhmm_times;
    return min( map time_diffs( @t[$_..$#t] ), 0..$#t );
}


use Test::More;

my @tests = (
    [ [ "00:04", "23:55", "20:00" ], 9 ],
    [ [ "00:00", "23:55", "20:00" ], 5 ],
    [ [ "01:01", "00:50", "00:57" ], 4 ],
    [ [ "10:10", "09:30", "09:00", "09:55" ], 15 ],
);

is shortest_time( @{$_->[0]} ), $_->[1],
    "shortest_time( @{$_->[0]} ) == " . ( $_->[1] // "undef" )
    for @tests;

done_testing;
