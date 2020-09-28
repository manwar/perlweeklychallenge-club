#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch_1.pl
#
#        USAGE: ./ch_1.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-080/
#               Challenge #1
#               Smallest Positive Number Bits
#
#       AUTHOR: Lubos Kolouch
#===============================================================================

use strict;
use warnings;
use List::Util qw/min/;
use feature qw/say/;

sub get_smallest_missing {
    my $arr = shift;

    # Let's see if are lucky and the minimum -1 is >0
    my $arr_min = min( grep { $_ > 0 } @$arr);

    return $arr_min-1 if $arr_min-1 > 0;

    # Not lucky, arr_min is 0, so need to iterate
    # NOTE: the excercise does not say what to do if there is nothing missing
    # so let's just return min + 1 and ask on Twitter the author :)
    
    while (1) {
        $arr_min++;

        return $arr_min unless grep { $_ == $arr_min } @$arr;
    }
}

use Test::More;

is(get_smallest_missing([5, 2, -2, 0]), 1);
is(get_smallest_missing([1, 8, -1]), 2);
is(get_smallest_missing([2, 0, -1]), 1);
is(get_smallest_missing([2, 0, 1]), 3);

done_testing;
