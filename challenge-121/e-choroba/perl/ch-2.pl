#!/usr/bin/perl
use warnings;
use strict;

use List::Util qw{ min };

sub tsp {
    my ($matrix) = @_;
    my %shortest;
    my @inv_mask;

    for my $k (1 .. $#$matrix) {
        $shortest{ 2 ** $k }{$k} = $matrix->[0][$k];
        $inv_mask[$k] = 2 ** @$matrix - 1 - 2 ** $k;
    }

    for my $size (2 .. $#$matrix) {
        my $binary = '1' x $size . '0' x ($#$matrix - $size);
        my $mask = oct("0b$binary") << 1;
        while ($mask) {
            my @S = grep substr($binary, $#$matrix - $_ , 1), 1 .. $#$matrix;
            for my $k (@S) {
                my @mins;
                my $from = $shortest{ $mask & $inv_mask[$k] };
                for my $m (@S) {
                    next if $m == $k;
                    push @mins, $from->{$m} + $matrix->[$m][$k];
                }
                $shortest{$mask}{$k} = min(@mins);
            }

            # Find the nearest smaller mask with the same number of 1's.
            # Similar to PWC 114/2.
            my $pos = rindex $binary, '10';
            if (-1 == $pos) {
                $mask = 0;

            } else {
                substr $binary, $pos, 2, '01';
                $binary .= '0' x substr($binary, $pos + 2) =~ tr/0//d;
                $mask = oct("0b$binary") << 1;
            }
        }
    }

    my $full_set = 2 ** @$matrix - 2;
    my $length = 'INF';
    for my $start (1 .. $#$matrix) {
        my $p = $shortest{$full_set}{$start} + $matrix->[$start][0];
        $length = $p if $p < $length;
    }
    return $length
}

use Test2::V0 -srand => time;
plan 3;

is tsp([[0, 5, 2, 7],
        [5, 0, 5, 3],
        [3, 1, 0, 6],
        [4, 5, 4, 0]]),
    10, 'Example 1';

is tsp([[0, 5, 3, 4],
        [5, 0, 1, 5],
        [2, 5, 0, 4],
        [7, 3, 6, 0]]),
    10, 'Example 1 rotated';

is tsp([[0, 1, 15, 6],
        [2, 0, 7, 3],
        [9, 6, 0, 12],
        [10, 4, 8, 0]]),
    21, 'Wikipedia Held-Karp algorithm example';

# BONUSES:

sub generate_random {
    my ($size) = @_;
    my $r = [map [map 1 + int rand 20, 1 .. $size], 1 .. $size];
    $r->[$_][$_] = 0 for 0 .. $size - 1;
    return $r
}

# About 19 seconds for size 20.
print "$_ ", tsp(generate_random($_)), "\n" for 15, 20;
