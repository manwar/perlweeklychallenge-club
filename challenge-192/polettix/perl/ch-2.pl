#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use List::Util 'sum';

my @inputs = map { split m{[\s,]+}mxs } @ARGV;
@inputs = qw< 1 0 5 > unless @inputs;

say equal_distribution(@inputs);

sub equal_distribution (@inputs) {
   my $total = sum(@inputs);
   return -1 if $total % @inputs;
   my $average = $total / @inputs;
   my ($delta, $moves) = (0, 0);
   for my $value (@inputs) {
      $moves += abs($delta);
      $delta += $value - $average;
   }
   return $moves;
}
