#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my $x = shift // 5;
my $y = shift // 4;
say total_zero($x, $y);

sub total_zero ($A, $B, $n = 0) {
   ($A, $B, $n) = ($B % $A, $A, $n + int($B / $A)) while $A;
   return $n;
}
