#!/usr/bin/perl

=pod

Perl Weekly Challenge - 136
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-136/#TASK2

Author: Niels 'PerlBoy' van Dijke

TASK #2 › Fibonacci Sequence
Submitted by: Mohammad S Anwar

You are given a positive number $n.

Write a script to find how many different sequences you can create using Fibonacci numbers where the sum of unique numbers in each sequence are the same as the given number.

  ||    Fibonacci Numbers: 1,2,3,5,8,13,21,34,55,89, …

NOTE: This script is a 100% copy of week 77, task 1!

=cut

use v5.16;
use strict;
use warnings;

# Unbuffered STDOUT
$|++;

use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum);
use Memoize;

# Prototypes
sub fibonacci ($);
sub getFibonacciNumbersSmallerN ($);
sub findFibonacciSumSolutions ($\@\@);

memoize('fibonacci');

my ($N) = @ARGV;

die "Input must be integer value and >= 2"
  unless (defined $N and $N =~ m#^[1-9][0-9]*$# and $N >= 2);

my @solutions;

my @fib = getFibonacciNumbersSmallerN($N);
findFibonacciSumSolutions($N, @solutions, @fib);

print "Input:\n";
printf "\t%s = %d\n\n", '$N', $N;

print "Output:\n";
if (scalar @solutions) {
  printf "\t%d as the sum of Fibonacci numbers (%s) is same as input number.\n",
          scalar(@solutions), 
          join(', ', map { '['.join(',',@$_).']' } @solutions);
} else {
  print "\tNo solution can be found.\n";
}


sub fibonacci ($) {
  my ($n) = @_;

  return 1 if ($n == 1 or $n == 2);

  return fibonacci($n - 1) + fibonacci($n - 2);
}


sub getFibonacciNumbersSmallerN ($) {
  my ($n) = @_;

  my @fib;

  my $i = 2;
  my $f;

  while ($f = fibonacci($i++) and $f < $n) {
    push(@fib, $f);
  }

  return @fib;
}


sub findFibonacciSumSolutions($\@\@) {
   my ($n, $arSol, $arFib) = @_;

   foreach my $level (1 .. scalar @$arFib) {
     my $iter = combinations($arFib, $level);
     while (my $arCombi = $iter->next) {
       push(@$arSol, $arCombi) 
        if (sum(@$arCombi) == $n);
     }
  }
}
