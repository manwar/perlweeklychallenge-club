#!/usr/bin/env raku
use v6;
sub MAIN ($m = 8, $n = 24) { put two-friendly($m, $n) ?? 1 !! 0 }
subset Pint of Int where * > 0;
sub two-friendly (Pint:D $m, Pint:D $n) { positive-power2(gcd($m, $n)) }
sub positive-power2 ($x) { $x > 1 && is-power2($x) }
multi sub is-power2 (1) { True }
multi sub is-power2 ($x where * <= 0) { False }
multi sub is-power2 ($x where * %% 2) { is-power2($x +> 1) }
multi sub is-power2 ($x) { False }
sub gcd ($A is copy, $B is copy) { ($A, $B) = $B % $A, $A while $A; $B }
