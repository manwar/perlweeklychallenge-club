#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # Sort the list
    my @ints_sorted = sort { $a <=> $b } @ints;

    # Count the occurrences of the same value in the list
    my $count =
      scalar( grep { $ints[$_] == $ints_sorted[$_] } ( 0 .. $#ints ) );

    say $count;
}

main(@ARGV);