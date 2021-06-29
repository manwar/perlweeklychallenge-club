#!/usr/bin/perl
use warnings;
use strict;

sub swap_nibbles {
    my ($n) = @_;
    return unpack C  =>
           pack   h2 =>
           unpack H2 =>
           pack   C  => $n
}

use Test2::V0;
plan(2);

is swap_nibbles(101), 86, 'Example 1';
is swap_nibbles(18), 33, 'Example 2';
