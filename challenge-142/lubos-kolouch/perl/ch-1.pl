#!/usr/bin/perl
use strict;
use warnings;

sub count_divisors_with_last_digit {
    my ($m, $n) = @_;
    my $count = 0;
    for my $i (1 .. $m) {
        if ($m % $i == 0 && $i % 10 == $n) {
            $count++;
        }
    }
    return $count;
}

print count_divisors_with_last_digit(24, 2), "\n";
print count_divisors_with_last_digit(30, 5), "\n";

