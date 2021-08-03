#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub is_ugly ($k) {
   for my $d (2, 3, 5) {
      $k /= $d until $k % $d;
   }
   return $k == 1;
}

sub ugly_number_at_position ($n) {
   die "invalid input '$n'\n" if $n !~ m{\A [1-9]\d* \z}mxs;
   state $cache = [1..6];
   while ($n > $cache->@*) {
      my $c = 1 + $cache->[-1];
      $c++ until is_ugly($c);
      push $cache->@*, $c;
   }
   return $cache->[$n - 1];
}

say ugly_number_at_position(shift || 8);
