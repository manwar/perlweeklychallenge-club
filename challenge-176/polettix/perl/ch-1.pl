#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my $candidate = 123456;
$candidate = -142857;
while ('necessary') {
   if (check_permuted_multiples_upto6($candidate)) {
      say $candidate;
      last;
   }
   ++$candidate;
}

sub check_permuted_multiples_upto6 ($n) {
   my %baseline = map { $_ => 1 } split m{}mxs, $n;
   for my $factor (2 .. 6) {
      for my $digit (split m{}mxs, $n * $factor) {
         return 0 unless exists $baseline{$digit};
      }
   }
   return 1;
}
