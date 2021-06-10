#!/usr/bin/env raku
use v6;

sub number-sequence (Int $N where * >= 10) {
   my $Nlength = $N.chars;
   SIZE:
   for 1 .. ($Nlength / 2) -> $l {
      my @retval = my $x = $N.substr(0, $l);
      my $start = $l;
      ++$x;
      while (my $available = $Nlength - $start) > 0 {
         my $xlen = $x.chars;
         next SIZE if $xlen > $available || $N.substr($start, $xlen) ne $x;
         @retval.push($x);
         $start += $xlen;
         ++$x;
      }
      return @retval;
   }
   return $N;
}

sub MAIN (*@inputs) {
   @inputs = < 1234 91011 10203 > unless @inputs.elems;
   number-sequence($_).join(',').put for @inputs;
}
