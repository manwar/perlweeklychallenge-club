#!/usr/bin/env perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-100/
# TASK #2 › Triangle Sum

use 5.030;
use warnings;

my @triangles = (
    [ [1], [2,4], [6,4,9], [5,1,7,2] ],
    [ [3], [3,1], [5,2,3], [4,3,1,3] ],
);

for my $i (0 .. $#triangles) {
    say "$i: ", triangle_sum($triangles[$i]);
}

sub triangle_sum {
    my ($triangle) = @_;

    my $min = 2 ** 30;

    my $find_minimum_sum = sub {
        my ($row, $col, $acc) = @_;

        $acc += $triangle->[$row][$col];

        if ($row == $#$triangle) {
            $min = $acc if $acc < $min;
        } elsif ($min > $acc) {
            __SUB__->($row+1, $col,   $acc);
            __SUB__->($row+1, $col+1, $acc);
        }
        return;
    };

    $find_minimum_sum->(0, 0, 0);

    return $min;
}

