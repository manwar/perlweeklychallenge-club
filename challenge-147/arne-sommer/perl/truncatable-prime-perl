#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';
use Math::Prime::Util 'is_prime';

no warnings qw(experimental::signatures);

my $limit = int($ARGV[0] || 20);

my @seq;

my $candidate = 1;

while (@seq < $limit)
{
  $candidate++;
  
  push(@seq, $candidate) if is_left_trunc($candidate);
}

say join(", ", @seq);

sub is_left_trunc ($prime)
{
  return 0 if $prime =~ /0/;

  for my $start (0 .. length($prime) -1)
  {
    return 0 unless is_prime(substr($prime, $start));
  }

  return 1;
}
