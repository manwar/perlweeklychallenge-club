#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

# Niven numbers are also known as Harshad numbers.  Coincidentally Harshad is
# my patronym.

# This script is dedicated to the memory of my father Dr. Harshad V. Vyas
# (1935-2019)

say 0;

for my $number (1 .. 50) {
    my $total = 0;
    for my $digit (split //, $number) {
        $total += $digit;
    }

    if ($number % $total == 0) {
        say $number;
    }
}

