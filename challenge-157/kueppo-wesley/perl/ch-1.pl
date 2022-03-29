#!/usr/bin/env perl

use strict;
use warnings;

use Math::BigFloat;

print "Input: ";
my @vars = split / +/, <STDIN>;

my($mul, $add, $frac) = (1, 0, 0);
foreach (@vars) {
    $mul *= $_;
    $add += $_;
    $frac += 1/$_;
}

$mul = Math::BigFloat->new(abs $mul);
printf "AM = %.1f, GM = %.1f, HM = %.1f\n", $add/@vars, $mul->broot(scalar @vars), @vars/$frac;
