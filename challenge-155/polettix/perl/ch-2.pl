#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say pisano_period(shift // 3);

sub pisano_period ($n) {
   my ($fl, $fh) = (0, 1 % $n);
   my $pp = 0;
   while ('necessary') {
      ($fl, $fh) = ($fh, ($fl + $fh) % $n);
      ++$pp;
      return $pp if $fl == 0 && $fh == 1 % $n;
   }
}
