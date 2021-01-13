#!/usr/bin/perl
use warnings;
use strict;

sub find_square {
    my ($square) = @_;
    my $square_tally = 0;
    for my $x1 (1 .. $#$square) {
        for my $y1 (1 .. $#{ $square->[$x1] }) {
            next unless $square->[$x1][$y1];

            my $max_size = $x1 > $y1 ? $y1 : $x1;
            for my $size (1 .. $max_size) {
                my $x0 = $x1 - $size;
                my $y0 = $y1 - $size;
                ++$square_tally
                    if $square->[$x0][$y0]
                    && $square->[$x1][$y0]
                    && $square->[$x0][$y1];
            }
        }
    }
    return $square_tally
}

use Test::More tests => 5;

is find_square([[ 0, 1, 0, 1 ],
                [ 0, 0, 1, 0 ],
                [ 1, 1, 0, 1 ],
                [ 1, 0, 0, 1 ]]), 1, 'Example 1';

is find_square([[ 1, 1, 0, 1 ],
                [ 1, 1, 0, 0 ],
                [ 0, 1, 1, 1 ],
                [ 1, 0, 1, 1 ]]), 4, 'Example 2';

is find_square([[ 0, 1, 0, 1 ],
                [ 1, 0, 1, 0 ],
                [ 0, 1, 0, 0 ],
                [ 1, 0, 0, 1 ]]), 0, 'Example 3';

is find_square([[ 1, 0, 0, 0, 0, 1 ],
                [ 1, 0, 0, 0, 0, 1 ],
                [ 0, 0, 0, 0, 0, 0 ],
                [ 0, 0, 0, 0, 0, 0 ],
                [ 0, 0, 0, 0, 0, 0 ],
                [ 1, 0, 0, 0, 0, 1 ],
                [ 1, 0, 0, 0, 0, 1 ]]), 2, 'm > n';

is find_square([[ 1, 0, 0, 1 ],
                [ 0, 0, 0, 0 ],
                [ 0, 0, 0, 0 ],
                [ 1, 0, 0, 1 ],
                [ 1, 0, 0, 1 ],
                [ 1, 0, 0, 1 ],
                [ 1, 0, 0, 1 ]]), 2, 'm < n';
