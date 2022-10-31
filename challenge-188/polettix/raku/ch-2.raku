#!/usr/bin/env raku
use v6;
sub MAIN ($x = 5, $y = 4) { put total-zero($x, $y) }

sub total-zero ($A is copy, $B is copy, $n is copy = 0) {
   ($A, $B, $n) = $B % $A, $A, $n + ($B / $A).Int while $A;
   return $n;
}
