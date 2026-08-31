#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub zigzag_subarray(@nums) {
    return 1 if 1 == @nums;
    return 2 if 2 == @nums && $nums[0] != $nums[1];

    my $longest = 1;
    my $from = 0;
    my $to = 0;
    while ($to++ < $#nums) {
        $from = $to, next if $nums[ $to - 1 ] == $nums[$to];

        $from = $to - 1, next if $to - $from > 1
                              && ($nums[$to] <=> $nums[ $to - 1 ])
                                  == ($nums[ $to - 1 ] <=> $nums[ $to - 2 ]);

        $longest = 1 + $to - $from if 1 + $to - $from > $longest;
    }
    return $longest
}

use Test::More tests => 5 + 2;

is zigzag_subarray(9, 4, 2, 10, 7, 8, 8, 1, 9), 5, 'Example 1';
is zigzag_subarray(1, 7, 4, 9, 2, 5), 6, 'Example 2';
is zigzag_subarray(1, 2, 3, 4, 5), 2, 'Example 3';
is zigzag_subarray(4, 4, 4), 1, 'Example 4';
is zigzag_subarray(10, 20, 15, 12, 18), 3, 'Example 5';

is zigzag_subarray(4), 1, 'Single element';
is zigzag_subarray(5, 5), 1, 'Equal adjacent numbers';
