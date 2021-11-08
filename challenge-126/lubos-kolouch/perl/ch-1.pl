#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: The Weekly Challenge 126
#  				Task 1 - Count Numbers
#
#       AUTHOR: Lubos
#      VERSION: 1.0
#      CREATED: 08/21/2021 12:05:53
#===============================================================================

use strict;
use warnings;

# so, to be honest, there is probably an easy mathematical solution, based on
# the fact there are:
#
# 9 numbers 1-9
# 9 * 9 numbers 1-100
# etc.
# So I can imagine a solution dividing the number by 10 and counting the
# numbers, but no time to play with it

sub get_numbers_without_1 {
    my $what = shift;

    my $count = 0;
    for (2..$what) {
        $count++ unless /1/;
    }

    return $count;
}

use Test::More;

is(get_numbers_without_1(15), 8, 'Test for 15');
is(get_numbers_without_1(25), 13, 'Test for 25');
done_testing;

