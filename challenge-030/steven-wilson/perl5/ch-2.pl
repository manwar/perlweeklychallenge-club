#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-10-14
# Week: 030

# Task #2
# Write a script to print all possible series of 3 positive numbers,
# where in each series at least one of the number is even and sum of the
# three numbers is always 12. For example, 3,4,5.

# Assumptions: 3,4,5 and 4,3,5 are distinct 'series'.

use strict;
use warnings;
use feature qw/ say /;
use List::Util qw/ sum any /;

my %series = ();

for my $i ( 1 .. 10 ) {
    for my $j ( 1 .. 10 ) {
        my $k = 12 - sum( $i, $j );
        if ( $k > 0 ) {
            if ( !exists $series{"$i, $j, $k"} ) {
                my $bool = any { $_ % 2 == 0 } ( $i, $j, $k );
                if ($bool) {
                    $series{"$i, $j, $k"} = 1;
                    $series{"$i, $k, $j"} = 1;
                    $series{"$j, $k, $i"} = 1;
                    $series{"$j, $i, $k"} = 1;
                    $series{"$k, $i, $j"} = 1;
                    $series{"$k, $j, $i"} = 1;
                }
            }
        }
    }
}

say join "\n", sort keys %series;
my $series_size = keys %series;
say "\nThere were $series_size possible series of 3 positive numbers.";
