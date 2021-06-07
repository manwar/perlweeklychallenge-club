#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my @tests = ( [34,1],[50,1],[52,0]);

is( sum_square($_->[0]), $_->[1] ) foreach @tests;

done_testing();

sub sum_square {
  my $sum = 0;                            ## Initialize sum
  $sum += $_*$_ foreach split //, shift;  ## Sum digits..
  return $sum == (int sqrt $sum)**2 || 0; ## Check is squared
}

