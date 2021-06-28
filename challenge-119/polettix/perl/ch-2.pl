#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub sequence_without_1_on_1 ($N) {
   my $candidate = 1;
   while ($N > 1) {
      $candidate = succ_of($candidate);
      --$N if $candidate !~ m{11}mxs;
   }
   return $candidate;
}

sub succ_of ($x) {
   $x = base_4_to_10($x);
   while ('necessary') {
      my $candidate = base_10_to_4(++$x);
      return $candidate if $candidate !~ m{0}mxs;
   }
}

sub base_4_to_10 ($x) {
   my $X = 0;
   for my $digit (split m{}mxs, $x) {
      $X = ($X << 2) + $digit;
   }
   return $X;
}

sub base_10_to_4 ($x) {
   my @digits;
   while ($x) {
      push @digits, $x & 0b11;
      $x >>= 2;
   }
   return join '', @digits ? reverse @digits : 0;
}

my @inputs = @ARGV ? @ARGV : qw< 5 10 60 >;
say sequence_without_1_on_1($_) for @inputs;
