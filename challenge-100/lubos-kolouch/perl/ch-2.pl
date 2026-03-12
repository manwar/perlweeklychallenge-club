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
    my @path_sums;

    for my $row (@$what) {
        my @next_sums;

        for my $index (0 .. $#$row) {
            my @parents;
            push @parents, $path_sums[$index] if $index < @path_sums;
            push @parents, $path_sums[$index - 1] if $index > 0;

            my $parent_sum = @parents ? (@parents == 1 ? $parents[0] : ($parents[0] < $parents[1] ? $parents[0] : $parents[1])) : 0;
            push @next_sums, $row->[$index] + $parent_sum;
        }

        @path_sums = @next_sums;
    }

    my $min_path = $path_sums[0];
    for my $path_sum (@path_sums[1 .. $#path_sums]) {
        $min_path = $path_sum if $path_sum < $min_path;
    }

    return $min_path;
}
use Test::More;

is( min_sums( [ [1], [ 2, 4 ], [ 6, 4, 9 ], [ 5, 1, 7, 2 ] ] ), 8 );
is( min_sums( [ [3], [3,1], [5,2,3], [4,3,1,3] ] ), 7 );

done_testing;
