#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw/min/;

sub min_zero_operations {
    my (@ints) = @_;

    my @positives = grep { $_ > 0 } @ints;

    return 0 if @positives == 0;

    my $smallest = min @positives;

    my $operations = 0;

    while ( $smallest > 0 ) {
        for my $i ( 0 .. $#ints ) {
            if ( $ints[$i] > 0 ) {
                $ints[$i] -= $smallest;
            }
        }
        $operations++;

        @positives = grep { $_ > 0 } @ints;
        $smallest  = @positives > 0 ? min(@positives) : 0;
    }

    return $operations;
}

print min_zero_operations( 0, 0, 0 ),       "\n";    # 0
print min_zero_operations( 1, 5, 0, 3, 5 ), "\n";    # 3
print min_zero_operations(0),               "\n";    # 0
print min_zero_operations( 2, 1, 4, 0, 3 ), "\n";    # 4
