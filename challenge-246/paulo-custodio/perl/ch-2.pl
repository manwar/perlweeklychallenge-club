#!/usr/bin/env perl

# Challenge 246
#
# Task 2: Linear Recurrence of Second Order
# Submitted by: Jorg Sommrey
#
# You are given an array @a of five integers.
#
# Write a script to decide whether the given integers form a linear recurrence
# of second order with integer factors.
#
# A linear recurrence of second order has the form
#
# a[n] = p * a[n-2] + q * a[n-1] with n > 1
#
# where p and q must be integers.
#
#
# Example 1
#
# Input: @a = (1, 1, 2, 3, 5)
# Output: true
#
# @a is the initial part of the Fibonacci sequence a[n] = a[n-2] + a[n-1]
# with a[0] = 1 and a[1] = 1.
#
# Example 2
#
# Input: @a = (4, 2, 4, 5, 7)
# Output: false
#
# a[1] and a[2] are even. Any linear combination of two even numbers with
# integer factors is even, too.
# Because a[3] is odd, the given numbers cannot form a linear recurrence of
# second order with integer factors.
#
# Example 3
#
# Input: @a = (4, 1, 2, -3, 8)
# Output: true
#
# a[n] = a[n-2] - 2 * a[n-1]

use Modern::Perl;

my $ITERS = 10000;
my $MAX_VALUE = 10;

my @ints = @ARGV;
say found_solution(@ints) ? 'true' : 'false';

sub found_solution {
    my(@ints) = @_;
    my %seen;
    for (1..$ITERS) {
        my $p = input_value();
        my $q = input_value();
        next if $seen{$p}{$q}++;
        return 1 if is_linear_recurrence($p, $q, @ints);
    }
    return 0;
}

sub input_value {
    return int(rand()*2*$MAX_VALUE-$MAX_VALUE);
}

sub is_linear_recurrence {
    my($p, $q, @ints) = @_;
    for my $i (2..$#ints) {
        return 0 if $ints[$i] != $p * $ints[$i-2] + $q * $ints[$i-1];
    }
    return 1;
}
