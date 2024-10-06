#!/usr/bin/env perl

# Challenge 174
#
# Task 1: Disarium Numbers
# Submitted by: Mohammad S Anwar
#
# Write a script to generate first 19 Disarium Numbers.
#
#     A disarium number is an integer where the sum of each digit raised to the
#     power of its position in the number, is equal to the number.
#
#
# For example,
#
# 518 is a disarium number as (5 ** 1) + (1 ** 2) + (8 ** 3) => 5 + 1 + 512 => 518

use Modern::Perl;
use List::Util 'sum';

sub is_disarium {
    my($n) = @_;
    my @digits = split //, $n;
    for my $i (1..@digits) {
        $digits[$i-1] = $digits[$i-1] ** $i;
    }
    return sum(@digits) == $n;
}

sub disarium_numbers {
    my($N) = @_;
    my $n = 1;
    my @result;
    while (@result < $N) {
        push @result, $n if is_disarium($n);
        $n++;
    }
    return @result;
}

@ARGV==1 or die "usage: ch-1.pl n\n";
say join ", ", disarium_numbers(shift);
