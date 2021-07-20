#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

## Pre-populate cache with first 3 values...
my %cache = (
 1 => [qw(1)],
 2 => [qw(11 2)],
 3 => [qw(111 12 21 3)],
);
say join "\n",'',"SIZE $_",'',@{pts($_)} foreach 0..20;
say '';
sub pts {
  ## Let's look at the first points scored - it is either
  ## 1, 2 or 3.
  ## So we then look to see how remaining points are scored
  ## these are 1 - followed by all combinations for n-1
  ##           2 - followed by all combinations for n-2
  ##           3 - followed by all combinations for n-3
  ## The special cases are therefore where any of these values
  ## are less than 1 - so we need to have pre-populated values
  ## for 1, 2 and 3 points (1; 11+2; 111+12+21+3 respectively)
  ## We cache values as we know that we will see certain
  ## values occuring repeatedly {e.g. the start sequences
  ## 111, 12, 21 3 all then get all sequences for n-3
  return $cache{$_[0]} ||= $_[0] < 1 ? [] : [
     map( {'1'.$_} @{pts( $_[0]-1 )} ),
     map( {'2'.$_} @{pts( $_[0]-2 )} ),
     map( {'3'.$_} @{pts( $_[0]-3 )} )
  ];
}

