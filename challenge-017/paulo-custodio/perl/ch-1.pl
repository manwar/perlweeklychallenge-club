#!/usr/bin/perl

# Challenge 017
#
# Task #1
# Create a script to demonstrate Ackermann function. The Ackermann function is
# defined as below, m and n are positive number:
#
#   A(m, n) = n + 1                  if m = 0
#   A(m, n) = A(m - 1, 1)            if m > 0 and n = 0
#   A(m, n) = A(m - 1, A(m, n - 1))  if m > 0 and n > 0
#
# Example expansions as shown in wiki page.
#
#  A(1, 2) = A(0, A(1, 1))
#          = A(0, A(0, A(1, 0)))
#          = A(0, A(0, A(0, 1)))
#          = A(0, A(0, 2))
#          = A(0, 3)
#          = 4

use strict;
use warnings;
use 5.030;

use Memoize;
memoize 'A';

sub A {
    no warnings 'recursion';
    my($m, $n) = @_;

    return $n+1                 if $m==0;
    return A($m-1, 1)           if $m>0 && $n==0;
    return A($m-1, A($m, $n-1)) if $m>0 && $n>0;
    die "invalid arguments A($m,$n)";
}

say A(@ARGV);
