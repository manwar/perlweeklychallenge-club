#!/usr/bin/env perl

use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use List::Util qw( min );

sub time_diffs( $fixed, @others ) {
    # Return all differences between one timestamp and a list of others. 
    # Use the time difference spanning over midnight if it is shorter
    # (by simply using the minimum of both).
    return
	map { my $d = abs( $fixed - $others[$_] ); min( $d, (24*60) - $d ); }
	    0..$#others;
}

sub shortest_time( @hhmm_times ) {
    # Turn HH:MM times into number of minutes.
    my @t = map { /^(\d+):(\d{2})$/; $1 * 60 + $2 } @hhmm_times;
    # Return the minimum of the time differences of every element with all
    # its successors. We can skip the last element, as it has no successor to
    # build a difference with. 
    # We simplify the parameter list by just giving the whole
    # slice instead of giving the first element and its successors separately.
    return min( map time_diffs( @t[ $_ .. $#t ] ), 0 .. ( $#t - 1 ) );
}


use Test::More;

my @tests = (
    [ [ "00:04", "23:55", "20:00" ], 9 ],
    [ [ "00:00", "23:55", "20:00" ], 5 ],
    [ [ "01:01", "00:50", "00:57" ], 4 ],
    [ [ "10:10", "09:30", "09:00", "09:55" ], 15 ],
);

is shortest_time( @{$_->[0]} ),
    $_->[1],
    "shortest_time( @{$_->[0]} ) == " . ( $_->[1] // "undef" )
    for @tests;

done_testing;
