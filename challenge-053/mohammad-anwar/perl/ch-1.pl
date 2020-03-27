#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Deep;

my $unit_tests = {
    90 => {
            in  => [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ],
            out => [ [ 7, 4, 1 ], [ 8, 5, 2 ], [ 9, 6, 3 ] ],
          },
   180 => {
            in  => [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ],
            out => [ [ 9, 8, 7 ], [ 6, 5, 4 ], [ 3, 2, 1 ] ],
          },
   270 => {
            in  => [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ],
            out => [ [ 3, 6, 9 ], [ 2, 5, 8 ], [ 1, 4, 7 ] ],
          },
};

foreach my $degree (sort { $a <=> $b } keys %$unit_tests) {
    my $in  = $unit_tests->{$degree}->{in};
    my $out = $unit_tests->{$degree}->{out};
    cmp_deeply(rotate_matrix($in, $degree), $out, "rotation by $degree.");
}

done_testing;

#
#
# METHODS

sub rotate_matrix {
    my ($matrix, $degree) = @_;

    foreach my $i ( 1 .. int($degree/90) ) {
        my $rows = @$matrix;
        my $cols = @{$matrix->[0]};

        my $_matrix = [];
        foreach my $i ( 0 .. $rows-1 ) {
            my $k = 2;
            foreach my $j ( 0 .. $cols-1 ) {
                $_matrix->[$i][$j] = $matrix->[$k][$i];
                $k--;
            }
        }
        $matrix = $_matrix;
    }

    return $matrix;
}
