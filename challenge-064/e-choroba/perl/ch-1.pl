#!/usr/bin/perl
use warnings;
use strict;

use utf8;

sub _mins {
    my @matrix = @_;
    my @mins = ([[$matrix[0][0]]]);
    my @agenda = ([0, 0]);
    while (@agenda) {
        my %next;
        for my $coord (@agenda) {
            my ($x, $y) = @$coord;
            for my $step ([1, 0], [0, 1]) {
                if (($x, $y)[ $step->[1] ] < $#matrix) {
                    my ($m, $n) = ($x + $step->[0], $y + $step->[1]);
                    my $weight = $mins[$x][$y][0] + $matrix[$m][$n];
                    if ($weight < ($mins[$m][$n][0] // ($weight + 1))) {
                        $mins[$m][$n] = [$weight, $x, $y];
                        ++$next{$m}{$n};
                    }
                }
            }
        }
        @agenda = ();
        for my $x (keys %next) {
            push @agenda, [$x, $_] for keys %{ $next{$x} };
        }
    }
    return @mins
}

sub minimum_path {
    my @matrix = @_;
    my @mins = _mins(@matrix);
    my $sum = $mins[$#matrix][$#matrix][0];
    my ($x, $y) = ($#matrix) x 2;
    my @path;
    while (defined $x) {
        unshift @path, $matrix[$x][$y];
        (undef, $x, $y) = @{ $mins[$x][$y] };
    }
    return "$sum (" . join(' → ', @path) . ')'
}

use Test::More;

is minimum_path([1, 2, 3],
                [4, 5, 6],
                [7, 8, 9]),
    '21 (1 → 2 → 3 → 6 → 9)';

is minimum_path([1, 1, 1, 1, 1, 1],
                [1, 9, 9, 9, 9, 1],
                [1, 9, 9, 9, 9, 1],
                [1, 9, 9, 9, 9, 1],
                [1, 9, 9, 9, 9, 1],
                [1, 1, 1, 1, 2, 1]),
    '11 (1 → 1 → 1 → 1 → 1 → 1 → 1 → 1 → 1 → 1 → 1)';

is minimum_path([1, 1, 1, 1, 1, 1],
                [1, 9, 9, 9, 9, 1],
                [1, 9, 9, 9, 9, 1],
                [1, 9, 9, 9, 9, 1],
                [1, 9, 9, 9, 9, 2],
                [1, 1, 1, 1, 1, 1]),
    '11 (1 → 1 → 1 → 1 → 1 → 1 → 1 → 1 → 1 → 1 → 1)';

is minimum_path([1, 1, 2, 9, 9, 9],
                [2, 1, 2, 2, 9, 9],
                [2, 1, 1, 1, 2, 9],
                [9, 2, 2, 1, 2, 9],
                [9, 9, 2, 1, 1, 2],
                [9, 9, 9, 2, 1, 1]),
    '11 (1 → 1 → 1 → 1 → 1 → 1 → 1 → 1 → 1 → 1 → 1)';

done_testing();
