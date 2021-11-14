#!/usr/bin/perl
use warnings;
use strict;

sub _split {
    my ($sum, $part) = @_;
    return 1 if $sum == $part;

    for my $length (1 .. length($part) - 1) {
        my $prefix = substr $part, 0, $length;
        return 1 if _split($sum - $prefix, substr $part, $length)
    }
    return 0
}

sub split_number {
    my ($square) = @_;
    return _split(sqrt $square, $square)
}

use Test2::V0;
plan 3;

is split_number(81), 1, 'Example 1';
is split_number(9801), 1, 'Example 2';
is split_number(36), 0, 'Example 3';
