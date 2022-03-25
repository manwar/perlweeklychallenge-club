#!/usr/bin/env perl

# Challenge 155
#
# TASK #2 › Pisano Period
# Submitted by: Mohammad S Anwar
# Write a script to find the period of the 3rd Pisano Period.
#
# In number theory, the nth Pisano period, written as p(n), is the period with
# which the sequence of Fibonacci numbers taken modulo n repeats.
#
# The Fibonacci numbers are the numbers in the integer sequence:
#
# 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, ...
# For any integer n, the sequence of Fibonacci numbers F(i) taken modulo n is
# periodic. The Pisano period, denoted p(n), is the value of the period of this
# sequence. For example, the sequence of Fibonacci numbers modulo 3 begins:
#
# 0, 1, 1, 2, 0, 2, 2, 1,
# 0, 1, 1, 2, 0, 2, 2, 1,
# 0, 1, 1, 2, 0, 2, 2, 1, ...
# This sequence has period 8, so p(3) = 8.

use Modern::Perl;
use Math::Fibonacci;

my $order = 3;

my @fibs = Math::Fibonacci::series(100);
my @fibs_mod = map {$_ % $order} @fibs;
say find_period(@fibs_mod);

sub find_period {
    my(@n) = @_;
    my $period = 1;
    while (1) {
        return 0 if 3*$period > scalar(@n);
        return $period if is_period($period, @n);
        $period++;
    }
    return 0;
}

sub is_period {
    my($period, @n) = @_;
    my @base = @n[0 .. $period-1];
    my @ord1 = @n[$period .. 2*$period-1];
    my @ord2 = @n[2*$period .. 3*$period-1];

    return 0 if "@base" ne "@ord1";
    return 0 if "@base" ne "@ord2";
    return 1;
}
