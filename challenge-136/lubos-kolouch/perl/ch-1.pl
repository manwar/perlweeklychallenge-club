#!/usr/bin/perl
use strict;
use warnings;

sub gcd {
    my ($a, $b) = @_;
    ($a, $b) = ($b, $a % $b) while $b;
    return $a;
}

sub is_power_of_two {
    my $n = shift;
    return ($n & ($n - 1)) == 0;
}

sub is_two_friendly {
    my ($m, $n) = @_;
    return is_power_of_two(gcd($m, $n));
}

print is_two_friendly(8, 24) ? "1\n" : "0\n";
print is_two_friendly(26, 39) ? "1\n" : "0\n";
print is_two_friendly(4, 10) ? "1\n" : "0\n";

