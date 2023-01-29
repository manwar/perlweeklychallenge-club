#!/usr/bin/env perl
use strict;
use warnings;
use Set::Scalar;

sub missing_numbers{
  my ($a,$b) = (Set::Scalar->new,Set::Scalar->new);
  $a->insert(@{$_[0]});
  $b->insert(0..@{$_[0]});
  $b - $a;
}

printf "%s\n", missing_numbers([0,1,3]);
printf "%s\n", missing_numbers([0,1]);

