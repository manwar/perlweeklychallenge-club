#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::MoreUtils qw{ part };

sub special_positions($matrix) {
    my $tally = 0;
    for my $row (@$matrix) {
        my ($zero, $one, $rest) = _zeroes_ones_rest($row);
        next if $rest || @{ $one // [] } != 1;

        my @col = map $_->[ $one->[0] ], @$matrix;
        my ($col_zero, $col_one, $col_rest) = _zeroes_ones_rest(\@col);
        ++$tally if ! $col_rest && 1 == @{ $col_one // [] };
    }
    return $tally
}

sub _zeroes_ones_rest ($arr) {
    part { $arr->[$_] == 0 ? 0
         : $arr->[$_] == 1 ? 1
         :                   2 } 0 .. $#$arr
}

use Test::More tests => 2 + 1;

is special_positions([[1, 0, 0],
                      [0, 0, 1],
                      [1, 0, 0]]),
    1,
    'Example 1';

is special_positions([[1, 0, 0],
                      [0, 1, 0],
                      [0, 0, 1]]),
    3,
    'Example 2';

is special_positions([[0, 0, 0, 3],
                      [1, 0, 2, 0],
                      [0, 1, 0, 0]]),
    1,
    'mxn';
