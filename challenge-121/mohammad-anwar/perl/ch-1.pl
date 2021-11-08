#!/usr/bin/perl

=head1 Task #1: Invert Bit

You are given integers 0 <= $m <= 255 and 1 <= $n <= 8.

Write a script to invert $n bit from the end of the binary representation of $m and print the decimal representation of the new binary number.

=head1 Example

    Input: $m = 12, $n = 3
    Output: 8

    Binary representation of $m = 00001100
    Invert 3rd bit from the end = 00001000
    Decimal equivalent of 00001000 = 8

    Input $m = 18, $n = 4
    Output: 26

    Binary representation of $m = 00010010
    Invert 4th bit from the end = 00011010
    Decimal equivalent of 00011010 = 26

=cut

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
