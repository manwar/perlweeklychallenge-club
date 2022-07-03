#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $n where * > 0 = 20) {
   my @abundants;
   my $candidate = 945;
   while @abundants < $n {
      @abundants.push: $candidate if is-abundant($candidate);
      $candidate += 2;
   }
   put @abundants.join(', ');
}

sub is-abundant (Int:D $n) { $n < [+] proper-positive-divisors($n) }

sub proper-positive-divisors (Int:D $n is copy where * != 0) {
   $n = $n.abs;
   my (@lows, @highs) = 1,;
   my ($lo, $hi) = (2, $n);
   while $lo < $hi {
      if $n %% $lo {
         @lows.push: $lo;
         $hi = ($n / $lo).Int;
         @highs.unshift: $hi if $hi != $lo;
      }
      ++$lo;
   }
   return [@lows.Slip, @highs.Slip];
}
