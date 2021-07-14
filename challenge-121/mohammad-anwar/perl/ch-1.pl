#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub invert_bit {
    my ($m, $n) = @_;

    die "ERROR: Missing 'm'.\n"    unless defined $m;
    die "ERROR: Invalid m = $m.\n" unless ($m >= 0 && $m <= 255);

    die "ERROR: Missing 'n'.\n"    unless defined $n;
    die "ERROR: Invalid n = $n.\n" unless ($n >= 1 && $n <= 8);

    my @b = split //, sprintf("%08b", $m);
    $b[-$n] = ($b[-$n])?(0):(1);
    return oct('0b' . join '', @b);
}

is(invert_bit(12, 3), 8);
is(invert_bit(18, 4), 26);

done_testing;
