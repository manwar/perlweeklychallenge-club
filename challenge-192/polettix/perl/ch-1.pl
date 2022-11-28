#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say binary_flip(shift // 5);

sub binary_flip ($n) {
   my $mask = 0x01;
   my $result = 0;
   while ($n) {
      $result |= $mask unless $n & 0x01;
      $n >>= 1;
      $mask <<= 1;
   }
   return $result;
}
