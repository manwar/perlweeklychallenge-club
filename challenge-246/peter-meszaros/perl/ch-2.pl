#!/usr/bin/env perl
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
# integer factors is even, too.  Because a[3] is odd, the given numbers cannot
# form a linear recurrence of second order with integer factors.
# 
# Example 3
# 
# Input: @a = (4, 1, 2, -3, 8)
# Output: true
# 
# a[n] = a[n-2] - 2 * a[n-1]
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
    [1, 1, 2, 3, 5],
    [4, 2, 4, 5, 7],
    [4, 1, 2, -3, 8],
];

# a[2] = p * a[0] + q * a[1]
# a[3] = p * a[1] + q * a[2]
# a[4] = p * a[2] + q * a[3]
# --------------------------
# p = (a[2] - q * a[1]) / a[0]
# q = (a[3] * a[0] - a[2] * a[1]) / (a[2] * a[0] - a[1] * a[1])
# r = p * a[2] + q + a[3]
# if p is int and q is int and r == a[4] then true else false
sub linreq_of_second_order
{
    my $l = shift;

    my $q = ($l->[3]*$l->[0] - $l->[2]*$l->[1]) /
        ($l->[2]*$l->[0] - $l->[1]*$l->[1]);
    my $p = ($l->[2] - $q*$l->[1]) / $l->[0];

    my $r = $p*$l->[2] + $q*$l->[3];

    return ($p == int($p) && $q == int($q) && $l->[4] == $r) ? 1 : 0;
}

is(linreq_of_second_order($cases->[0]),  1, '[1, 1, 2, 3, 5]');
is(linreq_of_second_order($cases->[1]),  0, '[4, 2, 4, 5, 7]');
is(linreq_of_second_order($cases->[2]),  1, '[4, 1, 2, -3, 8]');
done_testing();

exit 0;
