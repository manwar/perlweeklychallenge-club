#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say monotonic_array(@ARGV) ? 1 : 0;

sub monotonic_array (@array) {
   my $direction = 0;
   for my $i (1 .. $#array) {
      my $delta = $array[$i] - $array[$i - 1];
      return 0 if $direction * $delta < 0;
      $direction ||= $delta;
   }
   return 1;
}
