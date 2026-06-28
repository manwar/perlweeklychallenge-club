#!/usr/bin/env perl
use strict;
use warnings;
use ntheory qw(factor factor_exp);
use Test::More tests => 5;

sub big_and_little_omega{
  my @funcs = (\&factor_exp,\&factor);
  scalar($funcs[!!$_[1]]($_[0]))
}

is big_and_little_omega(100061,0),3,'Example 1';
is big_and_little_omega(971088,0),3,'Example 2';
is big_and_little_omega(63640,1),6,'Example 3';
is big_and_little_omega(988841,1),2,'Example 4';
is big_and_little_omega(211529,0),2,'Example 5';

