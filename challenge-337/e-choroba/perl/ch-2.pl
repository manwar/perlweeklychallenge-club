#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use PDL;

sub odd_matrix($row, $col, @locations) {
    my $m = zeroes($col, $row);
    for my $location (@locations) {
        $m->slice($location->[1]) += 1;
        $m->slice("", $location->[0]) += 1;
    }
    return ($m % 2)->sum
}

use Test::More tests => 5;

is odd_matrix(2, 3, [0, 1], [1, 1]), 6, 'Example 1';
is odd_matrix(2, 2, [1, 1], [0, 0]), 0, 'Example 2';
is odd_matrix(3, 3, [0, 0], [1, 2], [2, 1]), 0, 'Example 3';
is odd_matrix(1, 5, [0, 2], [0, 4]), 2, 'Example 4';
is odd_matrix(4, 2, [1, 0], [3, 1], [2, 0], [0, 1]), 8, 'Example 5';
