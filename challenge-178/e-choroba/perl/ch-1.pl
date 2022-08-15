#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

use Math::Complex qw{ cplx };

my $B = cplx(0, 2);
sub from_quater_imaginary_base ($q) {
    my $n = 0;
    my $e = 1;
    while (length $q) {
        $n += chop($q) * $e;
        $e *= $B;
    }
    return $n
}

my $SCHROEPPEL4 = 0xCCCCCCCC;
sub to_quater_imaginary_base ($n) {
    my $binary = sprintf '%08b', ($n + $SCHROEPPEL4) ^ $SCHROEPPEL4;
    my $q = "";
    while ($binary =~ /(..)/g) {
        $q .= oct("0b$1") . '0';
    }
    $q =~ s/^0+//;
    chop $q;
    return $q
}


use Test2::V0;
plan 5;

is from_quater_imaginary_base('10300'), 4;
is from_quater_imaginary_base('1101'), '-3-8i';
is from_quater_imaginary_base('1030003'), -13;

is to_quater_imaginary_base(4), '10300';
is to_quater_imaginary_base(-13), '1030003';
