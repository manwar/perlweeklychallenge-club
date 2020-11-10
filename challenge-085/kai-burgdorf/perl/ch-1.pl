#!/usr/bin/perl

use strict;
use warnings;

#Input: @R = (1.2, 0.4, 0.1, 2.5)
#Output: 1 as 1 < 1.2 + 0.4 + 0.1 < 2

#Input: @R = (0.2, 1.5, 0.9, 1.1)
#Output: 0

#Input: @R = (0.5, 1.1, 0.3, 0.7)
#Output: 1 as 1 < 0.5 + 1.1 + 0.3 < 2

#my @R = ( 1.2, 0.4, 0.1, 2.5 );
#my @R = ( 0.2, 1.5, 0.9, 1.1 );
my @R = ( 0.5, 1.1, 0.3, 0.7 );

my $output = "0\n";

for ( my $i = 0 ; $i < scalar @R - 2 ; $i++ ) {

    my $a = $R[$i];
    for ( my $j = 0 ; $j < scalar @R - 1 ; $j++ ) {

        my $b = $R[$j];
        for ( my $k = 0 ; $k < scalar @R ; $k++ ) {

            my $c   = $R[$k];
            my $sum = $a + $b + $c;

            if ( ( $i != $j && $i != $k && $j != $k ) && ( 1 < $sum && $sum < 2 ) ) {
                $output = "1 < ($a+$b+$c) < 2\n";
            }
        }
    }
}

print $output;
