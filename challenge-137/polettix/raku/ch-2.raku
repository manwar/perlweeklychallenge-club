#!/usr/bin/env raku
use v6;

sub MAIN (Int:D $x where 10 <= * <= 1000 = 196) { maybe-lychrel($x).put }

sub maybe-lychrel (Int:D $n is copy where * > 0) {
   while $n < 10000000 {
      my $r = $n.flip;
      return 0 if $n eq $r;
      $n += $r;
   }
   return 1;
}
