#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub largest_interval($int) {
    my $jump = 0;
    my $previous = 1;
    for my $i (1 .. $int) {
        next if $i =~ /(.).*\1/;

        my $j = $i - $previous;
        $jump = $j if $j > $jump;
        $previous = $i;
    }
    # Uncomment if you don't want to jump over the final number.
    # my $j = $int - $previous;
    # $jump = $j if $j > $jump;
    return $jump
}

use Test::More tests => 5;

is largest_interval(20), 2, 'Example 1';
is largest_interval(110), 4, 'Example 2';
is largest_interval(500), 11, 'Example 3';
is largest_interval(2026), 105, 'Example 4';
is largest_interval(10000), 105, 'Example 5';  # Or 124, 9876 .. 10_000.
