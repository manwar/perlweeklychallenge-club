#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my $n = shift // 5;
for my $b (1 .. $n) {
   my $a = 3 * $b - 1;
   my $c = 8 * $b - 3;

   my $sqrt = $b * sqrt($c);
   my $first = ($a + $sqrt) ** (1/3);
   my $second = ($sqrt - $a) ** (1/3);
   my $result = $first - $second;

   say "($a, $b, $c) -> $result";
}
