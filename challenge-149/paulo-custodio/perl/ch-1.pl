#!/usr/bin/env perl

# Challenge 149
#
# TASK #1 › Fibonacci Digit Sum
# Submitted by: Roger Bell_West
# Given an input $N, generate the first $N numbers for which the sum of their
# digits is a Fibonacci number.
#
# Example
# f(20)=[0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44]

use Modern::Perl;
use List::Util qw( sum );
use Math::Fibonacci qw( isfibonacci );

my $count = shift || 1;
my @out;
my $n = 0;
while (scalar(@out) < $count) {
    push @out, $n if sum_of_digits_is_fibonacci($n);
    $n++;
}
say join(", ", @out);


sub sum_of_digits_is_fibonacci {
    my($n) = @_;
    my @digits = split //, $n;
    my $sum = sum(@digits);
    return isfibonacci($sum);
}
