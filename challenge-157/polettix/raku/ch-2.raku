#!/usr/bin/env raku
use v6;
sub MAIN (*@args) {
   my @candidates = @args ?? @args !! (7, 6, 8);
   s{\,} = '' for @candidates;
   for @candidates -> $candidate {
      my $bb = is-brazilian($candidate);
      "$candidate -> {$bb ?? 1 !! 0} # $bb".put;
   }
}

multi sub is-brazilian (Int() $n where * > 3) {
   for 2 .. $n.sqrt -> $p {
      next unless $p.is-prime;
      next if $n % $p;
      my $b = ($n / $p - 1).Int;
      next if $b <= $p;
      return $b;
   }
   for (2 .. $n - 2).reverse -> $b {
      return $b if is-brazilian($n, $b);
   }
   return 0;
}

multi sub is-brazilian (Int:D $n is copy where * > 3, Int:D $b where * > 1) {
   my $digit = $n % $b;
   while $n > 0 {
      return 0 if $digit != $n % $b;
      $n = (($n - $digit) / $b).Int;
   }
   return 1;
}
