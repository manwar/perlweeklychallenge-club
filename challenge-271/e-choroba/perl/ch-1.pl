#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use PDL;

sub maximum_ones($matrix) {
    my $p   = pdl($matrix);
    my $sum = $p->sumover;
    my $max = $sum->max;
    return ($sum == $max)->which->unpdl->[0] + 1
}

use Test2::V0 qw{ plan is };  # Conflict with PDL::float.
plan(3 + 1);

is maximum_ones([[0, 1], [1, 0]]), 1, 'Example 1';
is maximum_ones([[0, 0, 0], [1, 0, 1]]), 2, 'Example 2';
is maximum_ones([[0, 0], [1, 1], [0, 0]]), 2, 'Example 3';


is maximum_ones([[0, 0, 0, 0],
                 [1, 1, 0, 1],
                 [0, 0, 1, 0],
                 [1, 0, 0, 0],
                 [0, 1, 1, 1]]),
    2, 'Example 4';
