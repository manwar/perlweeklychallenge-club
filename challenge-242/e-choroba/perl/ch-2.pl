#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use PDL;

sub flip_matrix($m) {
    ! pdl($m)->slice('-1:0:0')
}

use Test::More tests => 3;

is_deeply flip_matrix("[1 1 0]\n[0 1 1]\n[0 0 1]")->unpdl,
    [[1, 0, 0], [0, 0, 1], [0, 1, 1]],
    'Unnamed example';

is_deeply flip_matrix([[1, 1, 0], [1, 0, 1], [0, 0, 0]])->unpdl,
    [[1, 0, 0], [0, 1, 0], [1, 1, 1]],
    'Example 1';

is_deeply flip_matrix(
    [[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]]
)->unpdl,
    [[1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0]],
    'Example 2';
