#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my ($array, $idx) = @ARGV;
my @array = split /,/, $array;
my @idx   = split /,/, $idx;

for (@idx) {
  my @rotated = rotate($_, @array);
  say '[', join(', ', @rotated), ']';
}

sub rotate {
  my ($idx, @array) = @_;

  return @array[$idx .. $#array], @array[0 .. $idx - 1];
}
