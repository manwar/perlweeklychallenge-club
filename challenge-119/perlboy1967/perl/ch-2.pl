#!/usr/bin/perl

# Perl Weekly Challenge - 119
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-119/#TASK1
#
# Task 2 - Sequence without 1-on-1
#
# Author: Niels 'PerlBoy' van Dijke
#

use v5.16;
use strict;
use warnings;

# Prototype(s)
sub close2Base3Seq($);

use Test::More;

my $tests = [ 
   [  1,   1],
   [  4,  12],
   [  8,  23],
   [  9,  31],
   [ 15, 131],
   [ 60,2223],
];

foreach my $t (@$tests) {
  printf "%s\n", join(',', @$t) unless is(close2Base3Seq($t->[0]), $t->[1]);
}

done_testing();


sub close2Base3Seq($) {
  my ($n) = @_;

  state @cache; $cache[1] //= 1;

  # Try our luck using our cache
  return $cache[$n] if defined $cache[$n];

  my $maxN = scalar(@cache) - 1;

  while ($maxN < $n) {
    my $seqValue = $cache[$maxN++]+1;
    1 while ($seqValue =~ s#(.*)4#("0$1"+1).'1'#e or $seqValue =~ s#11#12#);
    $cache[$maxN] = $seqValue;
  } 

  return $cache[$n];
}

