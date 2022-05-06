#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say sum_bitwise(@ARGV);

sub sum_bitwise (@n) {
   return 0     if @n == 0;
   return $n[0] if @n == 1;
   my $retval = 0;
   for my $i (0 .. $#n - 1) {
      $retval += $n[$i] & $n[$_] for $i + 1 .. $#n;
   }
   return $retval;
}
