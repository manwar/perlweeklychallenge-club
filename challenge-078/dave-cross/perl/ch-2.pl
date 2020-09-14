#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';

my ($array, $idx) = @ARGV;
my @array = split /,/, $array;
my @idx   = split /,/, $idx;

say '[', join(', ', rotate($_, @array)), ']' for @idx;

sub rotate {
  my ($idx, @array) = @_;

  return @array[$idx .. $#array], @array[0 .. $idx - 1];
}
