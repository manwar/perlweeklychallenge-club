#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl  
#
#  DESCRIPTION: Perl Weekly Challenge 098
#               Task 2 - Search Insert Position
#               https://www.perlweeklychallenge.org
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 02/06/2021 10:10:41 AM
#===============================================================================

use strict;
use warnings;
use feature qw/say/;

sub search_position {
    my $what = shift;

    my $num = $what->[0];
    my $arr = $what->[1];

    my $arr_len = scalar(@{$arr});
    my $pos = int($arr_len / 2);

    # handle special cases first
    return 0 if $num <= $arr->[0];
    return $arr_len if $num >= $arr->[$arr_len-1];

    # half the interval until found or jump 1
    my $jump = $pos;
    while ($jump > 1) {
        return $pos if $arr->[$pos] == $num;
        $jump = int($jump / 2);
        if ($num > $arr->[$pos]) {
            $pos += $jump;
        } else {
            $pos -= $jump;
        }
    }

    return $pos;
}
use Test::More;

is(search_position([3, [1, 2, 3, 4]]), 2);
is(search_position([6, [1, 3, 5, 7]]), 3);
is(search_position([10, [12, 14, 16, 18]]), 0);
is(search_position([19, [11, 13, 15, 17]]), 4);


done_testing;
