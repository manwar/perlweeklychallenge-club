#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use Math::Combinatorics;

sub ones_and_zeroes($str, $x, $y) {
    for my $size (reverse 1 .. @$str) {
        my $comb = 'Math::Combinatorics'->new(data  => [@$str],
                                              count => $size);
        while (my @combo = $comb->next_combination) {
            my $joined = join "", @combo;
            my $zeroes = $joined =~ tr/0//;
            my $ones   = $joined =~ tr/1//;
            return $size if $zeroes <= $x && $ones <= $y;
        }
    }
    return 0
}

use Test::More tests => 2 + 2;

is ones_and_zeroes(["10", "0001", "111001", "1", "0"], 5, 3), 4, 'Example 1';
is ones_and_zeroes(["10", "1", "0"],  1, 1), 2, 'Example 2';

is ones_and_zeroes([], 0, 0), 0, 'Empty set';
is ones_and_zeroes(["1100", "111", "000"], 1, 1), 0, 'Empty subset';
