#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-017/
# Task #1
# Create a script to demonstrate Ackermann function. The Ackermann function is defined as below, m and n are positive number:
#  A(m, n) = n + 1                  if m = 0
#  A(m, n) = A(m - 1, 1)            if m > 0 and n = 0
#  A(m, n) = A(m - 1, A(m, n - 1))  if m > 0 and n > 0
#
# Example expansions as shown in wiki page.
# https://en.wikipedia.org/wiki/Ackermann_function
# A(1, 2) = A(0, A(1, 1))
#         = A(0, A(0, A(1, 0)))
#         = A(0, A(0, A(0, 1)))
#         = A(0, A(0, 2))
#         = A(0, 3)
#         = 4

use strict;
use warnings;
no warnings 'recursion';
#Deep recursion on subroutine "%s"
#(W recursion) This subroutine has called itself (directly or indirectly) 100 times more than it has returned.
#This probably indicates an infinite recursion, unless you're writing strange benchmark programs, in which case it indicates something else.

use Memoize;
memoize('a');

sub a {
    my ($m, $n) = @_;
    return $n+1 if ($m == 0);
    return a($m-1,1) if ($n == 0);
    return a($m-1,a($m,$n-1));
}

die "Usage: $0 <m,n>" unless ($ARGV[0] && $ARGV[0] =~ /\d,\d/);
print a(split /,/,$ARGV[0]);
