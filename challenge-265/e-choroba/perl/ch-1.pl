#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub pct33_appearance (@ints) {
    my %count;
    my $tally = 0;
    ++$tally, ++$count{$_} for @ints;
    return (sort { $a <=> $b }
            grep $count{$_} > $tally * 0.33,
            keys %count)[0]
}

use Test::More tests => 3 + 1;

is pct33_appearance(1, 2, 3, 3, 3, 3, 4, 2), 3, 'Example 1';
is pct33_appearance(1, 1), 1, 'Example 2';
is pct33_appearance(1, 2, 3), 1, 'Example 3';

is pct33_appearance(1, 2, 3, 4), undef, 'Nothing';
