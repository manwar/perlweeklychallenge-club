#!/usr/bin/env raku
use v6;

sub MAIN (Int:D $N = 10) {
   my @pernicious;
   my $k = 0;
   while @pernicious < $N {
      @pernicious.push: $k if is-pernicious($k);
      ++$k;
   }
   @pernicious.join(', ').put;
}

sub is-pernicious (Int:D $n where * >= 0) { $n.base(2).comb.sum.is-prime }
