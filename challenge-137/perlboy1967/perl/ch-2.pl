#!/bin/perl

=pod

Perl Weekly Challenge - 137
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-137/#TASK2

Author: Niels 'PerlBoy' van Dijke

TASK #2 › Lychrel Number
Submitted by: Mohammad S Anwar

You are given a number, 10 <= $n <= 1000.

Write a script to find out if the given number is Lychrel number. 
To keep the task simple, we impose the following rules:

a. Stop if the number of iterations reached 500.
b. Stop if you end up with number >= 10_000_000.

According to wikipedia:

  || A Lychrel number is a natural number that cannot form a palindrome through 
  || the iterative process of repeatedly reversing its digits and adding the 
  || resulting numbers.

=cut

use v5.16;
use strict;
use warnings;

use constant MAX_ITER => 500;
use constant MAX_VALUE => 10_000_000;

use Test::More;

# Prototype(s)
sub isLychrelNumber($$$;$);


my $N = shift // 89;

isLychrelNumber($N,MAX_ITER,MAX_VALUE,1);

my %tests = qw(56 0 57 0 59 0 89 -1);
foreach my $n (keys %tests) {
  is(isLychrelNumber($n,MAX_ITER,MAX_VALUE),$tests{$n});
}
done_testing();


sub isLychrelNumber($$$;$) {
  my ($n, $maxIter, $maxVal, $print) = @_;
  $print //= 0;

  my $return = -1;

  while (1) {
    my $nRev = reverse $n;
    print "$n + $nRev = " if $print;
    $n += $nRev;
    print "$n\n" if $print;

    # Max value exceeded?
    last if ($n > $maxVal);

    # Palindrome (using a recursive regular expression)?
    if ($n =~ /^((.)(?1)\2|.?)$/) {
      $return = 0;
      last;
    }

    # Max iterations exceeded?
    $maxIter--;
    last if ($maxIter < 0);
  }

  printf "%d => %d\n", $n, $return if $print;

  $return;
}
