#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub strong_pair(@ints) {
    @ints = sort { $a <=> $b } @ints;
    my %strong;
    for my $i (0 .. $#ints - 1) {
        for my $j ($i + 1 .. $#ints) {
            my $diff = $ints[$j] - $ints[$i];
            undef $strong{"@ints[$i, $j]"} if 0 < $diff
                                           && $diff < $ints[$i];
        }
    }
    return scalar keys %strong
}

use Test::More tests => 2;

is strong_pair(1, 2, 3, 4, 5), 4, 'Example 1';
is strong_pair(5, 7, 1, 7), 1, 'Example 2';
