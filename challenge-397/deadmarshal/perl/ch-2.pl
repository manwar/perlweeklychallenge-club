#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub binary_reflection{
  my $rb = sub{oct('0b' . reverse sprintf("%b",shift))};
  [sort{$rb->($a) <=> $rb->($b) || $a <=> $b} @{$_[0]}]
}

is_deeply binary_reflection([3,6,12]),[3,6,12],'Example 1';
is_deeply binary_reflection([1,2,4,8]),[1,2,4,8],'Example 2';
is_deeply binary_reflection([7,8,9,10]),[8,10,7,9],'Example 3';
is_deeply binary_reflection([5,9,15,17]),[5,9,15,17],'Example 4';
is_deeply binary_reflection([11,13,14,19]),[14,13,11,19],'Example 5';

