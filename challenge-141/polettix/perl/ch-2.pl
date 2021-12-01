#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub like_numbers ($m = 1234, $n = 2) {
   my @m = split m{}mxs, $m;
   my $bits = @m;
   my $N = 2 ** $bits - 2;
   my $c = 0;
   for my $i (1 .. $N) {
      my @b = split m{}mxs, sprintf "%0${bits}b", $i;
      my $v = join '', map { $b[$_] ? $m[$_] : () } 0 .. $#m;
      ++$c unless $v % $n;
   }
   return $c;
}

say like_numbers(@ARGV);
