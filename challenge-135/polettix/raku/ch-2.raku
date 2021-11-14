#!/usr/bin/env raku
use v6;
sub validate-SEDOL (Str() $s) {
   state @weights = 1, 3, 1, 7, 3, 9, 1;
   return 0 if $s !~~ /^ <[0..9 B..D F..H J..N P..T V..Z]> ** 6 <[ 0..9 ]> $/;
   my $sum = (0 .. 6).map({
      my $c = $s.substr($_, 1);
      my $n = $c le '9' ?? $c + 0 !! $c.ord - 'A'.ord + 10;
      @weights[$_] * $n;
   }).sum;
   return $sum % 10 ?? 0 !! 1;
}
put validate-SEDOL(@*ARGS[0] || 2936921);
