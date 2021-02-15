#!/usr/bin/env perl

use v5.10;
use warnings;

use List::Util 'min';

use Test::More;

sub minimum_path_sum {
    my ($tree, $x, $y) = @_;
    $x //= 0;
    $y //= 0;

    if ($y == $#$tree) {
        return $tree->[$y][$x];
    } else {
        my $sum1 = minimum_path_sum($tree, $x, $y + 1);
        my $sum2 = minimum_path_sum($tree, $x + 1, $y + 1);
        return $tree->[$y][$x] + min($sum1, $sum2);
    }
}

my $tree1 = [ [1], [2, 4], [6, 4, 9], [5, 1, 7, 2] ];
is minimum_path_sum($tree1), 8, 'example 1';

my $tree2 = [ [3], [3, 1], [5, 2, 3], [4, 3, 1, 3] ];
is minimum_path_sum($tree2), 7, 'example 2';

done_testing;