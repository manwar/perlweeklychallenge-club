#!/bin/perl

=pod

The Weekly Challenge - 149
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-149/#TASK1

Author: Niels 'PerlBoy' van Dijke

TASK #1 › Fibonacci Digit Sum
Submitted by: Roger Bell_West

Given an input $N, generate the first $N numbers for which the sum of their 
digits is a Fibonacci number.

=cut

use v5.16;

use List::Util qw(sum);
use Memoize;
use Data::Printer output => 'stdout';

# Prototypes
sub isFibonacciDigitSum($);
sub fibonacci ($);

memoize('fibonacci');

my ($N) = @ARGV; $N //= 20;

die "Input must be integer value and >= 1"
  unless (defined $N and $N =~ m#^[1-9][0-9]*$# and $N >= 1);

my @solutions;

my $n = 0;
while(scalar(@solutions) < $N) {
  push(@solutions, $n) if (isFibonacciDigitSum($n));
  $n++;
}

p @solutions;

sub isFibonacciDigitSum ($) {
  my ($n) = @_;

  state @fib;
  state %fib;

  my $digitSum = sum(split(//, $n));
  while (scalar(@fib) == 0 or $fib[-1] <= $digitSum) {
    push(@fib, fibonacci(scalar(@fib)));
    $fib{$fib[-1]}++;
  }

  return exists $fib{$digitSum} ? 1 : 0;
}
    
sub fibonacci ($) {
  my ($n) = @_;

  return 0 if ($n == 0);
  return 1 if ($n == 1 or $n == 2);
  return fibonacci($n - 1) + fibonacci($n - 2);
}
