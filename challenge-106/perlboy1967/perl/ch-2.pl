#!/usr/bin/perl

# Perl Weekly Challenge - 106
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-106/#TASK2
#
# Task 1 - Decimal String
#
# Author: Niels 'PerlBoy' van Dijke
#
# See: https://en.wikipedia.org/wiki/Repeating_decimal

use v5.16;
use strict;
use warnings;

@ARGV = (1, 46)
  unless scalar(@ARGV) >= 2;

my ($N, $D) = @ARGV;

die "\$N must be smaller than \$D ($D, $N)"
  unless ($N < $D);

printf "Input: \$N = %d, \$D = %d\n", $N, $D;
printf "Output: %d/%d = %s\n", $N, $D, decimalString($N, $D);


sub decimalString {
  my ($n, $d) = @_;

  my $result = ''; 

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
  return "0.$result" if ($r == 0);

  if ($result =~ m#([0]+)$#) { 
    $rSeen{$n}[0] -= length($1);
    $rSeen{$n}[1] -= length($1);
  }

  return sprintf('0.%s(%s)', 
                 substr($result, 0, $rSeen{$n}[0]),
                 substr($result, $rSeen{$n}[0], 
                        $rSeen{$n}[1] - $rSeen{$n}[0]));
} 
