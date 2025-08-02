#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub target_array($source, $indices) {
    my @target;
    splice @target, $indices->[$_], 0, $source->[$_] for 0 .. $#$indices;
    return \@target
}

use Test2::V0;
plan(3);

is target_array([0, 1, 2, 3, 4], [0, 1, 2, 2, 1]),
    [0, 4, 1, 3, 2],
    'Example 1';

is target_array([1, 2, 3, 4, 0], [0, 1, 2, 3, 0]),
    [0, 1, 2, 3, 4],
    'Example 2';

is target_array([1], [0]),
    [1],
    'Example 3';
