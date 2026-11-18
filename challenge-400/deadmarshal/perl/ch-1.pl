#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(reduce max);
use Test::More tests => 5;

sub largest_interval{
  my @nums = grep{!/(.).*\1/} 1..$_[0];
  my $jump = 0;
  reduce{$jump = max($jump,$b - $a); $b} @nums;
  $jump
}

is largest_interval(20),2,'Example 1';
is largest_interval(110),4,'Example 2';
is largest_interval(500),11,'Example 3';
is largest_interval(2026),105,'Example 4';
is largest_interval(10000),105,'Example 5';

