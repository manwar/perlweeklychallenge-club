#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $min = 1, Int:D $max = 10) {
   ($min .. $max).map({left-factorial($_)}).join(', ').put;
   ($min .. $max).map({left-factorial-cached($_)}).join(', ').put;
}

multi sub left-factorial (Int:D $n where 0 <= * <= 2) { $n }
multi sub left-factorial (Int:D $n where * >  2) {
   my $f = 1;
   1 + (1 ..^ $n).map({$f *= $^x}).sum;
}

sub left-factorial-cached (Int:D $n where * >= 0) {
   state $factorial = 1;
   state $k = 1;
   state @left-factorials = 0, 1, 2;
   while $n > @left-factorials.end {
      $factorial *= ++$k;
      @left-factorials.push: @left-factorials[*-1] + $factorial;
   }
   return @left-factorials[$n];
}
