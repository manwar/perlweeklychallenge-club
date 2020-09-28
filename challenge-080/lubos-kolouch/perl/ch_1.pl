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

    # map the arr to hash
    say min( grep { $_ > 0 } @$arr);

}

use Test::More;

is(get_smallest_missing([5, 2, -2, 0]), 1);
is(get_smallest_missing([1, 8, -1]), 2);
is(get_smallest_missing([2, 0, 1]), 1);

done_testing;
