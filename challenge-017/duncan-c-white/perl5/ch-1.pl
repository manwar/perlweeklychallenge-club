#!/usr/bin/perl
#
# Challenge 1: "Create a script to demonstrate Ackermann function. The
# Ackermann function is defined as below, m and n are positive number:
# 
#       A(m, n) = n + 1                  if m = 0
#       A(m, n) = A(m - 1, 1)            if m > 0 and n = 0
#       A(m, n) = A(m - 1, A(m, n - 1))  if m > 0 and n > 0
# 
# eg. A(1, 2) = A(0, A(1, 1))
#          = A(0, A(0, A(1, 0)))
#          = A(0, A(0, A(0, 1)))
#          = A(0, A(0, 2))
#          = A(0, 3)
#          = 4
# "
# 
# My notes:
# 
# Clearly described.  I seem to recall that the Ackermann function is
# tremendously inefficient to calculate recursively, but that memoization
# really helps.  So, before writing a line of code, I think "use Memoize"
# is going to help..

use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;
use Memoize;

die "Usage: ch-1.pl M N\n" unless @ARGV==2;
my $m = shift // 3;
my $n = shift // 100;

#
# my $amn = A($m,$n);
#	Calculate Ackermann's function for m,n>=0
#       A(m, n) = n + 1                  if m = 0
#       A(m, n) = A(m - 1, 1)            if m > 0 and n = 0
#       A(m, n) = A(m - 1, A(m, n - 1))  if m > 0 and n > 0
#
fun A( $m, $n )
{
	die "A($m,$n): m $m must be positive\n" if $m<0;
	die "A($m,$n): n $n must be positive\n" if $n<0;
	return $n+1 if $m == 0;
	return A($m-1,1) if $m>0 && $n==0;
        return A($m - 1, A($m, $n - 1));
}

memoize("A");

my $amn = A($m,$n);
print "A($m,$n) = $amn\n";
