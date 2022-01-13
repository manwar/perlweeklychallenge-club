#!/usr/bin/env raku
use v6;
subset Bin of Str where * ~~ /^ <[0 1]>+ $/;
sub add-binary (Bin() $a, Bin() $b) {
   return ($a.parse-base(2) + $b.parse-base(2)).base(2);
}
multi sub infix:<+> (Bin $A, Bin $B) { add-binary($A, $B) }
sub MAIN (Bin() $A = 101, Bin() $B = 11) { put $A + $B }
