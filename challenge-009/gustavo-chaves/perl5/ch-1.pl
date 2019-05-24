#!/usr/bin/env perl

use 5.026;
use strict;
use autodie;
use warnings;

my ($i, $square, %digits);

for ($i = 0; 5 != scalar keys %digits; ++$i) {
    $square = $i * $i;
    %digits = map {$_ => undef} split //, $square;
}

say "$i^2 == $square";
