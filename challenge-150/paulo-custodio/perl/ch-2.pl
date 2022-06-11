#!/usr/bin/env perl

# Challenge 150
#
# TASK #2 › Square-free Integer
# Submitted by: Mohammad S Anwar
# Write a script to generate all square-free integers <= 500.
#
# In mathematics, a square-free integer (or squarefree integer) is an integer
# which is divisible by no perfect square other than 1. That is, its prime
# factorization has exactly one factor for each prime that appears in it. For
# example, 10 = 2 · 5 is square-free, but 18 = 2 · 3 · 3 is not, because 18 is
# divisible by 9 = 3**2.
#
# Example
# The smallest positive square-free integers are
#     1, 2, 3, 5, 6, 7, 10, 11, 13, 14, 15, 17, 19, 21, 22, 23, 26, 29, 30, ...

use Modern::Perl;
use ntheory qw( factor_exp );

my @out;
for my $n (1..500) {
    push @out, $n if is_squarefree($n);
}
say join(", ", @out);

sub is_squarefree {
    my($n) = @_;
    my @factors = factor_exp($n);
    for (@factors) {
        my($p, $k) = @$_;
        return 0 if $k > 1;
    }
    return 1;
}
