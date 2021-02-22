#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch_2.pl
#
#        USAGE: ./ch_2.pl
#
#  DESCRIPTION: Perl Weekly Challenge #100
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-100/
#               Triangle Sum
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 2/20/2021 02:39:16 PM
#===============================================================================

use strict;
use warnings;

sub min_sums {
    my $what = shift;

    #
    # 1
    # |\
    # 2 4
    # |\|\
    # 6 4 9
    # |\|\|\
    # 5 1 7 2

    my $row_counter = 0;
    my $min_path;
    my %sums;
    for my $row (@$what) {
        $row_counter++;
        my $col_counter = 0;
        for my $item (@$row) {
            $col_counter++;
            my $min_sum;

            $min_sum = $sums{$row_counter-1, $col_counter} if exists($sums{$row_counter-1,$col_counter});
            $min_sum = $sums{$row_counter-1, $col_counter-1} if exists($sums{$row_counter-1,$col_counter-1}) and ( (not $min_sum) or ($sums{$row_counter-1,$col_counter-1} < $min_sum) );
            $min_sum //= 0;

            $sums{$row_counter,$col_counter} = $item + $min_sum;

            if ($row_counter == scalar @$what) {
                $min_path = $item + $min_sum if ( (not $min_path) or ($item + $min_sum < $min_path));
            }
        }
    }

    return $min_path;
}
use Test::More;

is( min_sums( [ [1], [ 2, 4 ], [ 6, 4, 9 ], [ 5, 1, 7, 2 ] ] ), 8 );
is( min_sums( [ [3], [3,1], [5,2,3], [4,3,1,3] ] ), 7 );

done_testing;
