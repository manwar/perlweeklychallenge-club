#!/usr/bin/env perl
use 5.020;
use warnings;
use strict;
use integer;

## Problem2

sub b35_digit {
    my $num = shift; # 0..34
    if ($num <= 9) {
        return chr($num+48);
    }
    return chr($num+55);
}

sub ord_b35_digit {
    my $num = ord(shift);
    if ($num >= 65) {
        return $num - 55;
    }
    return $num - 48;
}

sub num_to_b35 {
    my $num = shift;
    my $base = 35;
    my $string = '';
    while ($num > 0) {
        my $digit = b35_digit($num % $base);
        $string = $digit . $string;
        $num /= $base;
    }
    return $string;
}

sub b35_to_num {
    my @digits = split(//, shift);
    @digits = map {ord_b35_digit($_)} @digits;
    my $num = 0;
    my $base = 35;
    for (@digits) {
        $num *= 35;
        $num += $_;
    }
    return $num;
}

for (1..100) {
    say b35_to_num(num_to_b35($_));
}
