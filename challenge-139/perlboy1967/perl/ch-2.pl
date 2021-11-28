#!/bin/perl

=pod

The Weekly Challenge - 139
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-139/#TASK2

Author: Niels 'PerlBoy' van Dijke

Write a script to generate first 5 Long Primes.

 || A prime number (p) is called Long Prime if (1/p) has an infinite decimal
 || expansion repeating every (p-1) digits.

=cut

use v5.16;
use strict;
use warnings;

use Math::Prime::XS qw(is_prime);


# Re-usage of code week 106, task #2
sub repeatedDivDigits {
  my ($d) = @_;
  my ($n,$result) = (1,'');

  my %rSeen;
  my $r = $n;

  # Let's do a 'long div' and track if the
  # remainder becomes zero or if we've seen
  # a numerator before

  do {
    $n = $r;

    while ($n < $d) {
      $n .= '0';
      $result .= '0' if ($n < $d);
    }

    push(@{$rSeen{$n}}, length($result));

    $result .= int($n/$d)
      if (scalar(@{$rSeen{$n}}) < 2);

    $r = $n % $d;

  } while ($r != 0 and scalar(@{$rSeen{$n}} < 2));

  # Non repetitative division?
  return '' if ($r == 0);

  if ($result =~ m#([0]+)$#) {
    $rSeen{$n}[0] -= length($1);
    $rSeen{$n}[1] -= length($1);
  }

  return substr($result,
                $rSeen{$n}[0],
                $rSeen{$n}[1] - $rSeen{$n}[0]);
}

my @primes;

my $i = 1;
while (scalar(@primes) < 5) {
  push(@primes,$i)
    if (is_prime($i) and length(repeatedDivDigits($i)) == $i-1);
  $i++
}

printf "%s\n",join("\n",@primes);
