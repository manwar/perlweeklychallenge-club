#!/usr/bin/env raku
use v6;
subset PosInt where * > 0;
sub MAIN (PosInt:D $n is copy = 10) {
   my $x = 99;
   my @result = gather while $n > 0 {
      if is-circular-prime($x) {
         take $x;
         --$n;
      }
      $x += 2;
   }
   @result.join(', ').put;
}

sub is-circular-prime ($x is copy) {
   my $initial = $x;
   for 1 ..^ $x.chars {
      return False unless $x.is-prime;
      $x = $x.substr(*-1, 1) ~ $x.substr(0, *-1);
      return False if $x < $initial;
   }
   return $x.is-prime;
}
