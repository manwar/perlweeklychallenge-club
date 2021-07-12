#! /usr/bin/perl
use warnings;
use strict;

sub swap_odd_even_bits {
    my ($n) = @_;
    no warnings 'portable';
    oct '0b' . sprintf('%064b', $n) =~ s/(..)/reverse $1/ger
}

use Test2::V0;
plan(3);

is swap_odd_even_bits(101), 154, 'Example 1';
is swap_odd_even_bits(18),   33, 'Example 2';

# 255? Bah!
is swap_odd_even_bits(~0), ~0, 'Large value';
