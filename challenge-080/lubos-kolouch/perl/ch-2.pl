#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch_2.pl
#
#        USAGE: ./ch_2.pl  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-080/
#               Challenge #1
#               Count Candies
#
#       AUTHOR: Lubos Kolouch
#===============================================================================

use strict;
use warnings;
use List::Util qw/uniq/;

sub get_candle_count {
    my $arr = shift;

    # We need to give 1 candy to everyone
    my $count = scalar @$arr;

    # and then find out number of unique elements as they will be certainly
    # bigger than neighbor... -1 (the initial poor one)

    $count += scalar uniq @$arr;
    $count--;

    return $count;


}

use Test::More;

is(get_candle_count([1, 2, 2]), 4);
is(get_candle_count([1, 4, 3, 2]), 7);

done_testing;
