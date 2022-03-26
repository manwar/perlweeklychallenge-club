#!/usr/bin/env raku

#`[
sub same-digit($number, $base) {
  so enforce-digit($number, $base, Nil)
}
multi enforce-digit(0, $, Nil --> 0) {}
multi enforce-digit(0, $, $digit) { $digit }
multi enforce-digit($number, $base, Nil) {
  samewith $number div $base, $base, $number % $base
}
multi enforce-digit($number, $base, $digit where $number % $base != $digit --> Nil) {}
multi enforce-digit($number, $base, $digit) {
  samewith $number div $base, $base, $digit
}
]

sub enforce-same($a, $b) {
  $a eqv $b ?? $a !! Nil
}

sub same-digit($number, $base) {
  $number, * div $base ...^ 0
    andthen .map: * % $base
    andthen [[&enforce-same]] $_
    andthen True
    or False
}

sub is-brazilian(Int() $n) {
  so (2..^$n-1).any R[&same-digit] $n
}

my $n = prompt 'Input: $n = ';
say "Output: {is-brazilian($n) ?? 1 !! 0}";
