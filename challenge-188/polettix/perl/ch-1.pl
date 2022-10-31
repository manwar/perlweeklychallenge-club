#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say divisible_pairs(2, 4, 5, 1, 6);
say divisible_pairs(4, 7, 2, 4, 5);
say divisible_pairs(4, 7, 2, 6, 10, 1, 5, 3);

sub divisible_pairs ($k, @list) {
   my %rest_for;
   $rest_for{$_ % $k}++ for @list;
   my $handshakes = sub ($n) { int($n * ($n - 1) / 2) };
   my $n = $handshakes->($rest_for{0} // 0);
   for my $i (1 .. $k / 2) {
      my $j = $k - $i;
      $n += $j == $i ? $handshakes->($rest_for{$i} // 0)
         : ($rest_for{$i} // 0) * ($rest_for{$j} // 0);
   }
   return $n;
}
