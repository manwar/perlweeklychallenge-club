#!/usr/bin/env perl
use strict;
use warnings;

sub build_array{
  @{$_[0]}[@{$_[0]}];
}

printf "(%s)\n", join ',', build_array([0,2,1,5,3,4]);
printf "(%s)\n", join ',', build_array([5,0,1,2,3,4]);

