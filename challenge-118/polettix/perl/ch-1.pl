#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub binary_palindrome ($N) {
   die "invalid $N (positive integers are OK)\n"
      if $N !~ m{\A [1-9]\d* \z}mxs;
   return unless $N % 2;
   my ($M, $n) = (0, $N);
   ($M, $n) = (($M << 1) | ($n & 1), $n >> 1) while $n > 0;
   return $M == $N;
}

my @args = @ARGV ? @ARGV : 1 .. 31;
say $_, ' -> ', binary_palindrome($_) ? 1 : 0 for @args;
