#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: The Weekly Challenge #123
#               Task 1 - Ugly Numbers
#  
#       AUTHOR: Lubos Kolouch
#      CREATED: 07/30/2021 01:24:00 PM
#===============================================================================

use strict;
use warnings;
use List::Util qw/min/;
use Data::Dumper;


# So, I spent a lot of time on this... the reason is that I got sidetracked by
# the sentence "Ugly numbers are those number whose prime factors are 2, 3 or
# 5".
#
# So means that if I take number 14, it fits into this as 14 = 2 * 7, meaning
# that prime factor 2 meets the condition "2, 3 or 5".
#
# It even passed the tests suggested in the excercise as the biggest number
# returned (12) is below 14.
#
# Then I added more tests and realized, that the sentence should read something
# like "...whose prime factors are 2, 3 or 5 ONLY".
#
# Anyway, finally I just implemented the alghoritm from
# https://www.geeksforgeeks.org/ugly-numbers/

sub get_n_ugly {
    my $what = shift;

    my @ugly_cache = [1];

    my $ugly_2 = 2;
    my $index_2 = 0;
    my $ugly_3 = 3;
    my $index_3 = 0;
    my $ugly_5 = 5;
    my $index_5 = 0;

    for my $pos (1..$what-1) {
        my $next_ugly = min($ugly_2, $ugly_3, $ugly_5);
        $ugly_cache[$pos] = $next_ugly;

        if ($next_ugly == $ugly_2) {
            $index_2++;
            $ugly_2 = $ugly_cache[$index_2] * 2;
        }

        if ($next_ugly == $ugly_3) {
            $index_3++;
            $ugly_3 = $ugly_cache[$index_3] * 3;
        }

        if ($next_ugly == $ugly_5) {
            $index_5++;
            $ugly_5 = $ugly_cache[$index_5] * 5;
        }

    }

    return $ugly_cache[-1];
}


use Test::More;

is(get_n_ugly(7), 8);
is(get_n_ugly(10), 12);
is(get_n_ugly(150), 5832);
done_testing;

