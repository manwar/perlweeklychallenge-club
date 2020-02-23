#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

my @gapfuls;
my $number = 100;

while (scalar @gapfuls != 20) {
    my @digits = split //, $number;
    my $divisor = join q{}, ($digits[0], $digits[-1]);
    if ($number % $divisor == 0) {
        push @gapfuls, $number;
    }
    $number++;
}

say join ', ', @gapfuls;