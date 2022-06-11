#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use Memoize;

my $min = shift // 1;
my $max = shift // 10;
say join ', ', map { left_factorial($_) } $min .. $max;

memoize('left_factorial');
sub left_factorial ($n) {
   return $n if $n <= 2;
   return factorial($n - 1) + left_factorial($n - 1);
}

memoize('factorial');
sub factorial ($n) {
   return 1 if $n < 2;
   return $n * factorial($n - 1);
}
