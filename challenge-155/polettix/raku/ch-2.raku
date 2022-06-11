#!/usr/bin/env raku
use v6;

sub MAIN (Int:D $n = 3) { put pisano-period($n) }

multi sub pisano-period (1)  { return 1 }
multi sub pisano-period ($n) {
   my ($fl, $fh) = 0, 1;
   my $pp = 0;
   loop {
      ($fl, $fh) = $fh, ($fl + $fh) % $n;
      ++$pp;
      return $pp if $fl == 0 && $fh == 1;
   }
}
