#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-074/
#
#               TASK #1 › Majority Element
#
#       AUTHOR: Lubos Kolouch
#      VERSION: 1.0
#      CREATED: 08/22/2020 12:40:09 PM
#===============================================================================

use strict;
use warnings;

sub get_majority_element {
    my $arr = shift;

    my %counts;
    my $arr_size_half = scalar @$arr / 2;

    for (@$arr) {
        $counts{$_}++;
        return $_ if $counts{$_} > $arr_size_half;
    }

    return -1;
}

use Test::More;

is( get_majority_element( [ 1, 2, 2, 3, 2, 4, 2 ] ), 2 );
is( get_majority_element( [ 1, 3, 1, 2, 4, 5 ] ), -1 );

done_testing;
