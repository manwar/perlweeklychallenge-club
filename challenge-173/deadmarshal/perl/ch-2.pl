#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(product);
use Math::BigInt lib => 'GMP';

sub sylvesters_sequence{
  my @arr = (2,3);
  do{
    push @arr, Math::BigInt->new(product @arr[0..@arr-1]) + 1;
  }until(@arr == 10);
  return @arr;
}

print "$_\n" foreach(sylvesters_sequence);
