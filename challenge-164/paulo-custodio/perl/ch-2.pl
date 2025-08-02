#!/usr/bin/env perl

# Challenge 164
#
# Task 2: Happy Numbers
# Submitted by: Robert DiCicco
#
# Write a script to find the first 8 Happy Numbers in base 10. For more
# information, please check out Wikipedia.
#
# Starting with any positive integer, replace the number by the sum of the
# squares of its digits, and repeat the process until the number equals 1 (where
# it will stay), or it loops endlessly in a cycle which does not include 1.
#
# Those numbers for which this process end in 1 are happy numbers, while those
# numbers that do not end in 1 are unhappy numbers.
# Example
#
# 19 is Happy Number in base 10, as shown:
#
# 19 => 1^2 + 9^2
#    => 1   + 81
#    => 82 => 8^2 + 2^2
#          => 64  + 4
#          => 68 => 6^2 + 8^2
#                => 36  + 64
#                => 100 => 1^2 + 0^2 + 0^2
#                       => 1 + 0 + 0
#                       => 1

use Modern::Perl;
use List::Util 'sum';

sub is_happy {
    my($n)=@_;
    my %seen;
    while ($n!=1) {
        return 0 if $seen{$n}++;
        $n=sum(map {$_*$_} split //, $n);
    }
    return 1;
}

sub happy_numbers {
    my($n)=@_;
    my @happy;
    for (my $i=1; @happy<$n; $i++) {
        push @happy,$i if is_happy($i);
    }
    return @happy;
}

say join ", ", happy_numbers(shift);
