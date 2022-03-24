#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my @candidates = @ARGV ? @ARGV : (7, 6, 8);
for my $candidate (@candidates) {
   my $bb = is_brazilian($candidate);
   say "$candidate -> ", ($bb ? 1 : 0), " # $bb";
}

sub is_brazilian ($n) {
   for my $p (2, 3, 5, 7, 11, 13, 17, 19) {
      next if $n % $p;
      my $b = $n / $p - 1;
      next if $b <= $p;
      return $b;
   }
   return is_brazilian_bf($n);
}

sub is_brazilian_bf ($n) {
   BASE:
   for my $b (reverse 2 .. $n - 2) {
      return $b if is_brazilian_with($n, $b);
   }
   return 0;
}

sub is_brazilian_with ($n, $b) {
   use integer;
   my $digit = $n % $b;
   while ($n > 0) {
      return 0 if $digit != $n % $b;
      $n /= $b;
   }
   return 1;
}
