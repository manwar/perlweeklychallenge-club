#!/usr/bin/perl
use warnings;
use strict;

use enum qw( X Y COUNT );
use constant VERTICAL => 'vertical';

sub max_points {
    my @points = @_;
    my %repeated;
    ++$repeated{"@$_"} for @points;
    my @unique_points = map [split, $repeated{$_}], keys %repeated;

    my $max = 0;
    for my $ip (1 .. $#unique_points) {
        for my $q (@unique_points[0 .. $ip - 1]) {
            my $p = $unique_points[$ip];
            my $count = $p->[COUNT] + $q->[COUNT];
            my $A = $p->[X] == $q->[X]
                ? VERTICAL
                : ($p->[Y] - $q->[Y]) / ($p->[X] - $q->[X]);
            my $B = $A eq 'vertical' ? 0 : $p->[Y] - $A * $p->[X];
            for my $r (@unique_points[$ip + 1 .. $#unique_points]) {
                $count += $r->[COUNT]
                    if $A eq VERTICAL ? $r->[X] == $p->[X]
                                        : $A * $r->[X] + $B == $r->[Y];
            }
            $max = $count if $count > $max;
        }
    }
    return $max
}

use Test::More tests => 11;

is max_points([1, 1], [2, 2], [3, 3]), 3, 'Example 1';
is max_points([1,1], [2,2], [3,1], [1,3], [5,3]), 3, 'Example 2';

is max_points([1, 1], [1, 1], [1, 1], [1, 1],
              [2, 2], [2, 2], [2, 2],
              [1, 2], [1, 2],
              [3, 1]),
    7, 'duplicates';
is max_points([2, 2], [3, 2], [4, 2], [5, 2], [5, 3], [6, 7]), 4, 'horizontal';
is max_points([2, 2], [2, 3], [2, 4], [2, 5], [5, 3], [6, 7]), 4, 'vertical';
is max_points([0, 0], [0, 1], [0, 2],
              [1, 0], [1, 1], [1, 2],
              [2, 0], [2, 1], [2, 2]), 3, '3x3';
is max_points([0, 0], [0, 1], [0, 2],
              [1, 0], [1, 1], [1, 2],
              [2, 0], [2, 1], [2, 2],
              [4, 4]), 4, '3x3 diagonal';
is max_points([0, 0], [0, 1], [0, 2],
              [1, 0], [1, 1], [1, 2],
              [2, 0], [2, 1], [2, 2],
              [3, 0]), 4, '3x3 horizontal';
is max_points([0, 0], [0, 1], [0, 2],
              [1, 0], [1, 1], [1, 2],
              [2, 0], [2, 1], [2, 2],
              [2, 3]), 4, '3x3 vertical';

is max_points([1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6],
              map [$_, 3 * $_ - 1], 1 .. 6),
    6, 'larger';
cmp_ok max_points(sort { 1 - int rand 3 }
              (map [int rand 300, int rand 300], 1 .. 99),
              map [$_, 3 * $_ - 1], 1 .. 100),
    '>=', 100, 'large';
