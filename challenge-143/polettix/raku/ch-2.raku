#!/usr/bin/env raku
use v6;
subset PosInt of Int where * > 0;

sub is-stealthy (PosInt:D $n) {
   my $match = SetHash.new;
   for 1 .. $n.sqrt.Int -> $k {
      next unless $n %% $k;
      my Int() $sum = $k + $n / $k;
      return 1 if $match (&) ($sum - 1, $sum + 1);
      $match.set: $sum;
   }
   return 0;
}

sub MAIN (*@args) {
   @args = 36, 12, 6 unless @args.elems;
   "$_ -> {is-stealthy($_)}".put for @args;
}
