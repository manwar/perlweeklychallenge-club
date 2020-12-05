#!/usr/bin/env raku

sub MAIN( Int $N where $N > 1 ) {

   my $v = 0;
   my $str = (1..$N).combinations(2).map(->($a,$b){ $v += $a gcd $b; "gcd($a,$b)"}).join(" + ");

   "Input: $N".say;
   "Output: $v\n".say;

   $str.say;

}
