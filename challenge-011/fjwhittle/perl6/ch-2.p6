#!/usr/bin/env perl6

sub identity-matrix (UInt $n) {
  (^$n).map: -> $i { (^$n).map: -> $j { Int($j == $i) } };
}

#| Script to create an identity matrix
unit sub MAIN (
  UInt $n #= Dimensions of the generated matrix.
);

.say for identity-matrix $n;
