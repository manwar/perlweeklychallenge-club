#!/usr/bin/env perl

# Challenge 171
#
# Task 1: Abundant Number
# Submitted by: Mohammad S Anwar
#
# Write a script to generate first 20 Abundant Odd Numbers.
#
# According to wikipedia,
#
#     A number n for which the sum of divisors σ(n) > 2n, or, equivalently, the
#     sum of proper divisors (or aliquot sum) s(n) > n.
#
#
# For example, 945 is the first Abundant Odd Number.
#
# Sum of divisors:
# 1 + 3 + 5 + 7 + 9 + 15 + 21 + 27 + 35 + 45 + 63 + 105 + 135 + 189 + 315 = 975

use Modern::Perl;
use List::Util 'sum';

sub divisors {
    my($n) = @_;
    my(@div_low, @div_high);
    for (my $i = 1; $i <= sqrt($n); $i++) {
        if ($n%$i == 0) {
            push @div_low, $i;
            unshift @div_high, $n/$i if $n/$i != $i;
        }
    }
    return (@div_low, @div_high);
}

sub proper_divisors {
    my($n) = @_;
    my @div = divisors($n);
    return @div[0..$#div-1];
}

sub is_abundant {
    my($n) = @_;
    return sum(proper_divisors($n)) > $n;
}

sub abundant_numbers {
    my($N) = @_;
    my @abundant;
    my $n = 1;
    while (@abundant < $N) {
        push @abundant, $n if is_abundant($n);
        $n++;
    }
    return @abundant;
}

@ARGV==1 or die "usage: ch-1.pl n\n";
my $N = shift;
say join ", ", abundant_numbers($N);
