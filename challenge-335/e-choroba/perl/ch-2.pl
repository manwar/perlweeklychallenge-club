#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub find_winner(@moves) {
    my @grid;
    for my $i (0 .. $#moves) {
        $grid[ $moves[$i][0] ][ $moves[$i][1] ] = qw( A B )[ $i % 2 ];
    }
    my @patterns;
    push @patterns, [[0, 0], [1, 1], [2, 2]],
                    [[0, 2], [1, 1], [2, 0]];
    push @patterns, map { my $x = $_; [map [$x, $_], 0 .. 2] } 0 .. 2;
    push @patterns, map { my $y = $_; [map [$_, $y], 0 .. 2] } 0 .. 2;

    for my $pattern (@patterns) {
        my %seen;
        ++$seen{ $grid[ $_->[0] ][ $_->[1] ] // "" } for @$pattern;
        ($seen{$_} // 0) == 3 and return $_ for qw( A B );
    }

    return @moves < 9 ? 'Pending' : 'Draw'
}

use Test::More tests => 5 + 3;

is find_winner([0, 0], [2, 0], [1, 1], [2, 1], [2, 2]), 'A', 'Example 1';
is find_winner([0, 0], [1, 1], [0, 1], [0, 2], [1, 0], [2, 0]), 'B',
    'Example 2';
is find_winner([0, 0], [1, 1], [2, 0], [1, 0], [1, 2], [2, 1], [0, 1],
               [0, 2], [2, 2]),
    'Draw', 'Example 3';
is find_winner([0, 0], [1, 1]), 'Pending', 'Example 4';
is find_winner([1, 1], [0, 0], [2, 2], [0, 1], [1, 0], [0, 2]), 'B',
    'Example 5';

is find_winner([2, 0], [1, 0], [2, 1], [1, 1], [2, 2]), 'A', 'A row 2';
is find_winner([1, 1], [0, 0], [1, 0], [2, 2], [1, 2]), 'A', 'A col 1';
is find_winner(), 'Pending', 'Empty';
