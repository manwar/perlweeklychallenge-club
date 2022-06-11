#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $base = 10) {
   my @ls = largest-square($base);
   if $base <= 36 {
      turn-to-letters(@ls).join('').put;
   }
   else {
      @ls.join(' ').put;
   }
}

sub turn-to-letters (@sequence) {
   state @alphabet = ('0' .. '9', 'A' .. 'Z').flat;
   state %digit-for = (^@alphabet).map: { ($_, @alphabet[$_]).Slip };
   return @sequence.map: {%digit-for{~$_}};
}

sub largest-square ($base) {
   my $max = 0;
   $max = $max * $base + $_ for (^$base).reverse;
   my $candidate = 1 + $max.sqrt.Int;
   CANDIDATE:
   while True {
      --$candidate;
      my $square = $candidate * $candidate;
      my $present = SetHash.new;
      my @retval;
      while $square > 0 {
         my $v = $square % $base;
         next CANDIDATE if $present.EXISTS-KEY($v);
         $present.set($v);
         @retval.unshift: $v;
         $square = ($square / $base).Int;
      }
      return @retval;
   }
}
